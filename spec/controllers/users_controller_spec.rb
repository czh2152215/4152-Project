require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET register' do
    it 'assigns a new user' do
      get :register
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the register template' do
      get :register
      expect(response).to render_template(:register)
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new user and redirects' do
        expect {
          post :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)

        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a user and re-renders the register template' do
        expect {
          post :create, params: { user: { username: '', email: 'user@example.com', password: 'password' } }
        }.not_to change(User, :count)

        expect(response).to render_template(:register)
      end
    end
  end

  describe 'GET show' do
    let(:user) { create(:user) }

    before do
      session[:user_id] = user.id
      get :show, params: { id: user.id }
    end

    it 'assigns the current user' do
      expect(assigns(:current_user)).to eq(user)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end
end
