class Blogpost < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  validates :title, presence: true
  validates :category, presence: true
  validates :content, presence: true
  validates :image, presence: true
  CATEGORIES = ['Technical', 'Others']

  has_many :comments, foreign_key: 'blog_id', dependent: :destroy
end
