class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy #自分からの通知
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy #相手からの通知

  #フォローした、フォローされた関係
  has_many :follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy

  #一覧画面で使う
  has_many :followings, through: :follows, source: :followed
  has_many :followers, through: :reverse_of_follows, source: :follower

  has_one_attached :profile_image

  validates :name, presence: true
  validates :password, length: { minimum: 6 }, on: :create
  validates :email, uniqueness: true

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  #フォローした時の処理
  def follow(user_id)
    follows.create(followed_id: user_id)
  end

  #フォローを外すときの処理
  def unfollow(user_id)
    follows.find_by(followed_id: user_id).destroy
  end

  #フォローしているかの判定
  def following?(user)
    followings.include?(user)
  end

  # ゲストログイン
  def self.guest
    find_or_create_by!(email: "guest@guest") do |user|
      user.password =SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end

  # フォロー通知
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, id, "follow"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: "follow"
      )
      notification.save if notification.valid?
    end
  end

  #退会しているユーザー
  scope :deleted_true, -> { where.not(is_deleted: true) }

  #フォローしているユーザー（退会済みは除外する）
  def following_users
    followings.where(is_deleted: false)
  end

  #フォローされているユーザー（退会済みは除外する）
  def follower_users
    followers.where(is_deleted: false)
  end


end
