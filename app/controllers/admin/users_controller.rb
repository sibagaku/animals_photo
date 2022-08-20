class Admin::UsersController < ApplicationController

  def index
    @users = User.all.page(params[:page]).per(9)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(9)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :self_introduction, :is_deleted)
  end

end
