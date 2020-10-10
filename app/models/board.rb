class Board < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title,   presence: true, length: { maximum: 50 }
  default_scope -> { order(created_at: :desc) }
  has_many :board_comments, dependent: :destroy
end
