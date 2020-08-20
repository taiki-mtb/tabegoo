class Notification < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :restaurant_id, presence: true
  validates :from_user_id, presence: true
  default_scope -> { order(created_at: :desc) }
end
