class Restaurant < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 140 }
end
