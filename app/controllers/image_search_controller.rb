require 'net/http'
require 'uri'
require 'json'
class ImageSearchController < ApplicationController
  before_action :require_login, only: [:upload, :search]
  def upload
    render 'image_search/upload'
  end
  def search
    if params[:file].present?
      base64_image = convert_to_base64(params[:file])
      artwork_id = get_artwork_id_from_api(base64_image)
      # Simulate artwork identification by fetching a pre-stored artwork
      # @artwork = Artwork.find_by(id: params[:id])

      # only for test purpose, need to update once image recognition is implemented
      if params[:file].original_filename == 'no_match_image.jpeg'
        @artwork = nil
      else
        #fetch default artwork
        @artwork = Artwork.find_by(id: artwork_id)
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

  def get_artwork_id_from_api(base64_image)
    uri = URI('http://3.84.212.73:5001/process_image')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request.body = { image: base64_image }.to_json

    response = http.request(request)
    if response.code == '200'
      JSON.parse(response.body)['id']
    else
      nil
    end
  end

  def convert_to_base64(file)
    # Read the file and encode it
    Base64.encode64(File.read(file.tempfile))
  end

end
