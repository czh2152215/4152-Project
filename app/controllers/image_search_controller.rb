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
        redirect_to artwork_path(@artwork)
      else
        redirect_to root_path, alert: 'No artwork found for the uploaded image.'
      end

    else
      redirect_to root_path, alert: 'No file uploaded.'
    end
  end
end