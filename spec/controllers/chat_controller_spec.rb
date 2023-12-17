require 'rails_helper'

RSpec.describe ChatController, type: :controller do
  describe 'GET show' do
    it 'assigns @artwork_name from params' do
      artwork_name = 'Mona Lisa'
      get :show, params: { artwork_name: artwork_name }

      expect(assigns(:artwork_name)).to eq(artwork_name)
    end

    it 'renders the show template' do
      get :show, params: { artwork_name: 'Mona Lisa' }

      expect(response).to render_template(:show)
    end
  end
end
