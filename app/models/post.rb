class Post < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  has_many   :comments,  dependent: :destroy
  has_many   :favorites, dependent: :destroy
  has_many   :taggings,  dependent: :destroy
  has_many   :tags,      through:   :taggings

  #バリデーション
  validates :title, presence: true
  validates :body,  presence: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search(search)
    if search != ""
      Post.where('title LIKE(?)', "%#{search}%")
    else
      Post.includes(:user)
    end
  end

end
