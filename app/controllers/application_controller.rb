class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?

  def current_user
    #@current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: 'You must be logged in to access this page.'
    end
  end

  def user_signed_in?
    !current_user.nil?
  end
end
