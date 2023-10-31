class ArtworksController < ApplicationController
  def show
    @artwork = Artwork.find_by(id: params[:id])
    unless @artwork
      redirect_to root_path, alert: 'No artwork found with that artwork ID.'
    end
  end
end
