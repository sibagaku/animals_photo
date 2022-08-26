class Public::NotificationsController < ApplicationController

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

end
