class SessionsController < ApplicationController
  def login
    # Render the login form (new.html.erb)
  end

  def create
    user = User.find_by(username: params[:session][:username_or_email]) ||
      User.find_by(email: params[:session][:username_or_email])

    if user
      log_in(user)
      redirect_to user_path(user)  # Replace with the desired redirection
    else
      flash.now[:danger] = 'Invalid username/email and password combination'
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

  # Define the log_out method to log the user out by removing the session
  def log_out
    session.delete(:user_id)
    @current_user = user # Set an instance variable to store the logged-in user
  end
end
