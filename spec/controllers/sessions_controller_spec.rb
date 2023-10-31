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
      let!(:user) do
        create(:user, username: 'user1', email: 'user1@example.com', password: 'password', password_confirmation: 'password')
      end

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

      it 'does not set an error flash message' do
        post :create, params: { session: { username_or_email: 'user1', password: 'password' } }
        expect(flash[:danger]).to be_nil
      end

    end

    context 'with invalid credentials' do
      it 'renders the login template with an error' do
        post :create, params: { session: { username_or_email: 'wronguser', password: 'wrongpassword' } }
        expect(session[:user_id]).to be_nil
        expect(flash[:danger]).to eq('Invalid username/email and password combination, please try again')
        expect(response).to render_template(:login)
      end

      it 'does not log in with non-existent username or email' do
        post :create, params: { session: { username_or_email: 'nonexistent@example.com', password: 'password' } }
        expect(session[:user_id]).to be_nil
        expect(flash[:danger]).to eq('Invalid username/email and password combination, please try again')
        expect(response).to render_template(:login)
      end
    end
  end
  describe "DELETE #destroy" do
    before do
      @user = FactoryBot.create(:user)
      session[:user_id] = @user.id  # Simulate user login
    end

    it "logs out the user" do
      delete :destroy 
      expect(session[:user_id]).to be_nil
      expect(assigns(:current_user)).to be_nil
    end
  end
end
