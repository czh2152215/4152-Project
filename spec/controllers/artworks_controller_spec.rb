require 'rails_helper'

RSpec.describe ArtworksController, type: :controller do
  # describe 'GET index' do
  #   it 'assigns @artworks and renders the index template' do
  #     get :index
  #     expect(assigns(:artworks)).to eq(Artwork.all)
  #     expect(response).to render_template(:index)
  #   end
  # end

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
    context 'when user is logged in' do
      let(:artwork) { create(:artwork) }
      let(:user) { create(:user) } # Assuming you have a factory for user

      before do
        allow(controller).to receive(:current_user).and_return(user)
        get :show, params: { id: artwork.id }
      end

      it 'assigns @is_favorited based on user favorites' do
        expect(assigns(:is_favorited)).to eq(user.favorited_artworks.include?(artwork))
      end
    end
  end
  # Tests for the favorite action
  describe 'POST favorite' do
    let(:artwork) { create(:artwork) }
    let(:user) { create(:user) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    it 'adds artwork to user favorites and redirects' do
      expect {
        post :favorite, params: { id: artwork.id }
      }.to change { user.favorited_artworks.count }.by(1)
      expect(response).to redirect_to(artwork_path(artwork))
    end
  end

  # Tests for the unfavorite action
  describe 'POST unfavorite' do
    let(:artwork) { create(:artwork) }
    let(:user) { create(:user) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
      user.add_to_favorites(artwork)
    end

    it 'removes artwork from user favorites and redirects' do
      expect {
        post :unfavorite, params: { id: artwork.id }
      }.to change { user.favorited_artworks.count }.by(-1)
      expect(response).to redirect_to(artwork_path(artwork))
    end
  end
end
