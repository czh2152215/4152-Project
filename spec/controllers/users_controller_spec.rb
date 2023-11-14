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
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end
  
  describe 'GET #edit' do
    let(:user) { create(:user) }  # Assuming you're using FactoryBot for fixtures

    before do
      session[:user_id] = user.id
      get :edit, params: { id: user.id }
    end

    it 'assigns @user' do
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end
  end

    describe 'PATCH #update' do
    let(:user) { create(:user) }

    context 'with valid attributes' do
      before do
        session[:user_id] = user.id
        patch :update, params: { id: user.id, user: { username: 'newusername', email: 'newemail@example.com' } }
      end

      it 'updates the user' do
        user.reload
        expect(user.username).to eq('newusername')
        expect(user.email).to eq('newemail@example.com')
      end

      it 'redirects to the show page with a notice' do
        expect(response).to redirect_to(user_profile_path(user))
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid attributes' do
      before do
        session[:user_id] = user.id
        patch :update, params: { id: user.id, user: { username: '', email: 'invalidemail' } }
      end

      it 'does not update the user' do
        user.reload
        expect(user.email).not_to eq('invalidemail')
      end

      it 're-renders the edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end

end
