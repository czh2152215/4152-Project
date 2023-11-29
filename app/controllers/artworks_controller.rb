class ArtworksController < ApplicationController
  # index show all artworks in main page
  def index
    @artworks = Artwork.all
  end

  def show
    @artwork = Artwork.find_by(id: params[:id])
    unless @artwork
      redirect_to root_path, alert: 'No artwork found with that artwork ID.'
    end
  end

  def favorite
    artwork = Artwork.find(params[:id])
    current_user.add_to_favorites(artwork)
    redirect_to artwork_path(artwork)
  end


end
