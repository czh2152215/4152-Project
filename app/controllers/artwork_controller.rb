class ArtworkController < ApplicationController
  def index
    @artwork = Artwork.find_by(uid: params[:uid])
    unless @artwork
      redirect_to root_path, alert: 'No artwork found with that UID.'
    end
  end
end
