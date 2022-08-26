class Public::FollowsController < ApplicationController
  def create #フォローするとき
    current_user.follow(params[:user_id])
    user = User.find(params[:user_id])
    user.create_notification_follow!(current_user)
    redirect_to request.referer
  end

  def destroy #フォロー外すとき
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings #フォロー一覧
    @user = User.find(params[:user_id])
    @users = @user.followings.page(params[:page]).per(10)
  end

  def followers #フォロワー一覧
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page]).per(10)
  end

end
