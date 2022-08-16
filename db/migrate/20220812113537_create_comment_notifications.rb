class CreateCommentNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_notifications do |t|
      
      t.integer :comment_id, null: false
      t.integer :sent_notification_user_id, null: false
      t.integer :received_notification_user_id, null: false
      t.boolean :is_active, null: false, default: false


      t.timestamps
    end
  end
end
