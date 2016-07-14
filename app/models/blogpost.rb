class Blogpost < ActiveRecord::Base
  validates :title, presence: true
  validates :category, presence: true
  validates :content, presence: true
  CATEGORIES = ['Technical', 'Others']
end
