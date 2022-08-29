class Public::UsersController < ApplicationController


  def index
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%").where.not(id: current_user.id)
    else
      @users = User.none
    end
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
    redirect_to user_path(@user.id)
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdral
    @user = current_user
    @user.update(is_deleted: true) #会員の情報を有効から退会にする
    reset_session #情報の削除
    redirect_to root_path
  end

  def follow
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(10)
  end

  def follower
    @user = User.find(params[:id])
    @users = @user.follow.page(params[:page]).per(10)
  end


  def search

  end

  def bookmark
    @favorites = Favorite.where(user_id: current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :self_introduction)
  end
end
