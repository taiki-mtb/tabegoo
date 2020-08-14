class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :restaurant_id, presence: true 
end
