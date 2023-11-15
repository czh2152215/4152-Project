class SessionsController < ApplicationController
  def login
    # Render the login form (new.html.erb)
  end

  def create
    user = User.find_by(username: params[:session][:username_or_email]) ||
      User.find_by(email: params[:session][:username_or_email])

    # 这里添加对密码的验证
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to user_path(user)
    else
      Rails.logger.info("Logging in failed!")  # 添加这行日志记录
      flash.now[:danger] = 'Invalid username/email and password combination, please try again'
      render 'login'
    end
  end

  def destroy
    # Log the user out and redirect to the homepage
    session[:user_id] = nil
    redirect_to root_url
  end

  private

  # Define the log_in method to set the session
  def log_in(user)
    session[:user_id] = user.id
  end

  # def welcome
  #   # Get ten random artworks in welcome page
  #   if session[:user_id]
  #     @user = User.find(session[:user_id])
  #     @random_artworks = Artwork.order(Arel.sql('RANDOM()')).limit(10)
  #   else
  #     redirect_to login_path, alert: "You must be logged in to access this page."
  #   end
  # end

  # Define the log_out method to log the user out by removing the session
  # def log_out
  #   session.delete(:user_id)
  #   @current_user = user # Set an instance variable to store the logged-in user
  # end
end
