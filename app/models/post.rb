class Post < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  has_many   :comments,  dependent: :destroy
  has_many   :favorites, dependent: :destroy

  #バリデーション
  validates :title, presence: true
  validates :body,  presence: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
