class Post < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  has_many   :comments,  dependent: :destroy
  has_many   :favorites, dependent: :destroy
  has_many   :taggings,  dependent: :destroy
  has_many   :tags,      through:   :taggings
  FILE_NUMBER_LIMIT = 4

  #バリデーション
  validates :title, presence: true
  validates :body,  presence: true
  validate  :validate_number_of_files

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

  private

  def validate_number_of_files
    return if images.length <= FILE_NUMBER_LIMIT
    errors.add(:images, "添付できる画像は最大#{FILE_NUMBER_LIMIT}件までです。")
  end
end
