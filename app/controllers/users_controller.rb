class UsersController < ApplicationController

  def register
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # User registration successful, handle as needed (e.g., sign them in).
      redirect_to root_path, notice: 'Registration Successful!'
    else
      render 'register'
    end
  end

  def show #login in successfully
    @user ||= User.find_by(id: session[:user_id])
    #@random_artworks = Artwork.order(Arel.sql('RANDOM()')).limit(10)
    @random_artworks = Artwork.order(Arel.sql('RANDOM()')).distinct(:some_unique_attribute).limit(10)

  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    if @user.update(user_params)
      redirect_to user_profile_path(@user), notice: 'User Info Updated'
    else
      render :edit
    end
  end

  def profile
    @user = User.find(session[:user_id])
  end

  private


  def user_params
    params.require(:user).permit(:username, :email, :password, :profile_picture)
  end
end
