require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET login' do
    it 'renders the login template' do
      get :login
      expect(response).to render_template(:login)
    end
  end

  describe 'POST create' do
    context 'with valid credentials' do
      let!(:user) { create(:user, username: 'user1', email: 'user1@example.com', password: 'password') }

      it 'logs in with username and redirects' do
        post :create, params: { session: { username_or_email: 'user1', password: 'password' } }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(user_path(user))
      end

      it 'logs in with email and redirects' do
        post :create, params: { session: { username_or_email: 'user1@example.com', password: 'password' } }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(user_path(user))
      end
    end

    context 'with invalid credentials' do
      it 'renders the login template with an error' do
        post :create, params: { session: { username_or_email: 'wronguser', password: 'wrongpassword' } }
        expect(session[:user_id]).to be_nil
        expect(flash[:danger]).to be_present
        expect(response).to render_template(:login)
      end
    end
  end

end
