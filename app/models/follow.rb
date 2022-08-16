class Follow < ApplicationRecord
    
    belongs_to :user
    has_many :follow_notifications, dependent: :destroy
    
end
