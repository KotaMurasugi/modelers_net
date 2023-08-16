class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :posts,     dependent: :destroy
  has_many :comments,  dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_users, through: :followed, source: :follower
  has_many :following_users, through: :follower, source: :followed

#フォローメソッド
  def follow(user_id)
   follower.create(followed_id: user_id)
  end

#フォロー解除メソッド
  def unfollow(user_id)
   follower.find_by(followed_id: user_id).destroy
  end

#フォローの確認
  def following?(user)
   following_user.include?(user)
  end

#ゲストユーザー用
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "guestuser"
    end
  end

#プロフィール画像用
  def get_profile_image(w, h)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      profile_image.attach(io: File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [w, h]).processed
  end
end
