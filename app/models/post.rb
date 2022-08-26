class Post < ApplicationRecord

    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :notifications, dependent: :destroy

    has_one_attached :image

    def favorited_by?(user)
        favorites.exists?(user_id: user.id)
    end
    
    def create_notification_favorite!(current_user)
        #すでにいいねされているかの確認
        temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, "favorite"])
        #いいねされていない場合、通知レコードを作成する
        if temp.blank?
            notification = current_user.active_notifications.new(
                post_id: id,
                visited_id: user_id,
                action: "favorite"
            )
            notification.save if notification.valid?
        end
    end
    
    def create_notification_comment!(current_user, comment_id)
        #自分以外にコメントしている人をすべて取得し、全員に通知を送る
        temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
        temp_ids.each do |temp_id|
            save_notification_comment!(current_user, comment_id, temp_id["user_id"])
        end
        #まだ誰もコメントしていない場合は、投稿者に通知を送る
        save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
    end
    
    def save_notification_comment!(current_user, comment_id, visited_id)
        #１つの投稿に対して複数回のコメントをする可能性もある
        notification = current_user.active_notifications.new(
            post_id: id,
            comment_id: comment_id,
            visited_id: visited_id,
            action: "comment"
        )
        #自分の投稿に対する通知は、通知済みとする
        if notification.visited_id == notification.visitor_id
            notification.checked = true
        end
        notification.save if notification.valid?
    end

end
