require 'rails_helper'

RSpec.describe ImageSearchController, type: :controller do
  # Setup for tests
  let(:artwork) { create(:artwork) }
  let(:user) { create(:user) }


  describe 'GET #upload' do
    context 'when not logged in' do
        it 'redirects to login page' do
          session[:user_id] = nil
          get :upload
          expect(response).to redirect_to(login_path)
          expect(flash[:alert]).to eq('You must be logged in to access this page.')
        end
    end
    context 'when logged in' do

      before do
        log_in user
      end
      it 'renders the upload template' do
        get :upload
        expect(response).to render_template('image_search/upload')
      end
    end
  end

  before do
    log_in user
  end
  describe 'POST #search' do
    let(:valid_file) { Rack::Test::UploadedFile.new('features/support/fixtures/starry_night.jpeg', 'image/jpeg') }
    let(:invalid_file) { Rack::Test::UploadedFile.new('features/support/fixtures/no_match_image.jpeg', 'image/jpeg') }

    context 'when a file is uploaded' do
      it 'redirects to the artwork page if artwork is found' do
        allow(Artwork).to receive(:find_by).with(anything()).and_return(artwork)
        post :search, params: { file: valid_file }
        expect(response).to redirect_to(artwork_path(artwork))
      end

      it 'redirects to upload path if no artwork matches' do
        allow(Artwork).to receive(:find_by).and_return(nil)
        post :search, params: { file: invalid_file }
        expect(response).to redirect_to(upload_path)
        expect(flash[:alert]).to eq('No artwork found for the uploaded image. Try another one.')
      end
    end

    context 'when no file is uploaded' do
      it 'redirects to root path with an alert' do
        post :search # No file param
        expect(response).to redirect_to(upload_path)
        expect(flash[:alert]).to eq('No file uploaded.')
      end
    end

    context 'when an API call is made' do
      it 'calls the get_artwork_id_from_api method' do
        allow(controller).to receive(:get_artwork_id_from_api).and_return(artwork.id)
        post :search, params: { file: valid_file }
        expect(controller).to have_received(:get_artwork_id_from_api)
      end
    end

    context 'updating artwork history for the user' do
      it 'adds the artwork to user\'s history' do
        allow(Artwork).to receive(:find_by).with(anything()).and_return(artwork)
        expect { post :search, params: { file: valid_file } }
          .to change { user.reload.artworks_history.count }.by(1)
      end
    end
  end
end
