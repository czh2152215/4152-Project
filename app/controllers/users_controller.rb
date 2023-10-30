class UsersController < ApplicationController
  def register
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # User registration successful, handle as needed (e.g., sign them in).
      redirect_to root_path, notice: 'Registration successful!'
    else
      render 'register'
    end
  end

  def show #login in successfully
    @current_user ||= User.find_by(id: session[:user_id])
  end


  private


  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
