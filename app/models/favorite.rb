class Favorite < ApplicationRecord

    belongs_to :user
    belongs_to :post

    #退会しているユーザー
    scope :active, -> { joins(post: :user).where.not(posts: {users: {is_deleted: true}}) }

end
