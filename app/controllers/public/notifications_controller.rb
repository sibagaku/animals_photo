class Public::NotificationsController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:index]


  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy_all
    notifications = current_user.passive_notifications
    notifications.destroy_all
    redirect_to user_notifications_path(current_user.id)
  end

  private

  def correct_user
    @user = User.find(params[:user_id])
    redirect_to user_path(current_user.id) unless @user == current_user
  end

end
