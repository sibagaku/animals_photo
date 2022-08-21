class Follow < ApplicationRecord
    
    #class_name: "User"でUserモデルを参照する
    belongs_to :follower, class_name: "User"  #フォローする側
    belongs_to :followed, class_name: "User"  #フォローされる側
    has_many :follow_notifications, dependent: :destroy
    
end
