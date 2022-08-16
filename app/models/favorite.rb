class Favorite < ApplicationRecord
    
    belongs_to :user
    belongs_to :post
    has_many :favorite_notifications, dependent: :destroy
    
end
