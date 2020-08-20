class Comment < ApplicationRecord
  belongs_to :restaurant
  validates  :user_id, presence: true
  validates  :restaurant_id, presence: true
  validates  :content, presence: true, length: { maximum: 50 }
end
