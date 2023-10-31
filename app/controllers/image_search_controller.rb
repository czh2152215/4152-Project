class ImageSearchController < ApplicationController
  def search
    # @artwork = Artwork.find_by(uid: params[:uid])
    @artwork = Artwork.find_by(uid: "1")
    unless @artwork
      redirect_to root_path, alert: 'No image found with that UID.'
      return  # 使用 return 确保动作在此处停止执行
    end
    redirect_to artwork_path(@artwork.uid)
  end
end