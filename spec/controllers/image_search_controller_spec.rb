require 'rails_helper'

RSpec.describe ImageSearchController, type: :controller do
  # Setup for tests
  let(:artwork) { create(:artwork) }

  describe 'POST #search' do
    let(:valid_file) { Rack::Test::UploadedFile.new('features/support/fixtures/starry_night.jpeg', 'image/jpeg') }
    let(:invalid_file) { Rack::Test::UploadedFile.new('features/support/fixtures/no_match_image.jpeg', 'image/jpeg') }

    context 'when a file is uploaded' do
      it 'redirects to the artwork page if artwork is found' do
        allow(Artwork).to receive(:find_by).with(anything()).and_return(artwork)
        post :search, params: { file: valid_file }
        expect(response).to redirect_to(artwork_path(artwork))
      end

      it 'redirects to root path if no artwork matches' do
        allow(Artwork).to receive(:find_by).and_return(nil)
        post :search, params: { file: invalid_file }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('No artwork found for the uploaded image.')
      end
    end

    context 'when no file is uploaded' do
      it 'redirects to root path with an alert' do
        post :search # No file param
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('No file uploaded.')
      end
    end
  end
end
