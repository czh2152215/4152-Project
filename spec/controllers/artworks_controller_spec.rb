require 'rails_helper'

RSpec.describe ArtworksController, type: :controller do
  describe 'GET show' do
    context 'when artwork exists' do
      let(:artwork) { create(:artwork) }  # Assuming you have a factory for artwork

      it 'assigns @artwork and renders the show template' do
        get :show, params: { id: artwork.id }
        expect(assigns(:artwork)).to eq(artwork)
        expect(response).to render_template(:show)
      end
    end

    context 'when artwork does not exist' do
      it 'redirects to root path with an alert' do
        get :show, params: { id: 'nonexistent' }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to match(/No artwork found with that artwork ID./)
      end
    end
  end
end
