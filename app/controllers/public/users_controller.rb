class Public::UsersController < ApplicationController

  def notification

  end

  def index

  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def unsubscribe

  end

  def withdral

  end

  def follow

  end

  def follower

  end


  def search

  end

  def bookmark
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :self_introduction)
  end
end
