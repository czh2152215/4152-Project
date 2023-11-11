class ImageSearchController < ApplicationController
  before_action :require_login, only: [:upload, :search]
  def upload
    render 'image_search/upload'
  end
  def search
    if params[:file].present?
      # Simulate artwork identification by fetching a pre-stored artwork
      # @artwork = Artwork.find_by(id: params[:id])

      # only for test purpose, need to update once image recognition is implemented
      if params[:file].original_filename == 'no_match_image.jpeg'
        @artwork = nil
      else
        #fetch default artwork
        @artwork = Artwork.find_by(id: '1')
      end

      if @artwork
        update_artworks_history(current_user, @artwork.id)
        redirect_to artwork_path(@artwork)
      else
        redirect_to upload_path, alert: 'No artwork found for the uploaded image. Try another one.'
      end

    else
      redirect_to upload_path, alert: 'No file uploaded.'
    end
  end

  def update_artworks_history(user, artwork_id)
    # Assuming artwork_history is an array of artwork IDs
    user.artworks_history = [] unless user.artworks_history
    user.artworks_history.push(artwork_id)
    user.save
  end
end