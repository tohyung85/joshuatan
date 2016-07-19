class Comment < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 3}
  validates :message, presence: true, length: {minimum: 3}
  belongs_to :blogpost
end
