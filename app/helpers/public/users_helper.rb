module Public::UsersHelper

  def unchecked_notifications
    notifications = current_user.passive_notifications.where(checked: false)
  end

end
