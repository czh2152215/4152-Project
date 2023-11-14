require 'rails_helper'

# Dummy controller to test ApplicationController
class DummyController < ApplicationController
  before_action :require_login, only: [:restricted_action]

  def unrestricted_action; end

  def restricted_action; end
end

RSpec.describe DummyController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before do
    routes.draw { get "unrestricted_action" => "dummy#unrestricted_action"; get "restricted_action" => "dummy#restricted_action" }
  end

  describe '#current_user' do
    it 'returns the user when logged in' do
      session[:user_id] = user.id
      get :unrestricted_action
      expect(assigns(:current_user)).to eq(user)
    end

    it 'returns nil when not logged in' do
      get :unrestricted_action
      expect(assigns(:current_user)).to be_nil
    end
  end

  describe '#require_login' do
    context 'when not logged in' do
      it 'redirects to login page' do
        get :restricted_action
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq('You must be logged in to access this page.')
      end
    end

    context 'when logged in' do
      it 'allows access to the action' do
        session[:user_id] = user.id
        get :restricted_action
        expect(response).not_to redirect_to(login_path)
      end
    end
  end

  describe 'GET #check_user_signed_in' do
    context 'when the user is logged in' do
      before do
        session[:user_id] = user.id
        get :check_user_signed_in
      end

      it 'returns true' do
        expect(response.body).to eq 'true'
      end
    end

    context 'when no user is logged in' do
      before { get :check_user_signed_in }

      it 'returns false' do
        expect(response.body).to eq 'false'
      end
    end
  end
end
