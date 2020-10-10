class BoardComment < ApplicationRecord
  belongs_to :board
  validates  :user_id,  presence: true
  validates  :board_id, presence: true
  validates  :content,  presence: true, length: { maximum: 1000 }
end
