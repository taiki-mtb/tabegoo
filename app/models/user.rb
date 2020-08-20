class User < ApplicationRecord
  has_many :restaurants, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  attr_accessor :remember_token
  before_save :downcase_email
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def feed
    Restaurant.all
  end

  def favorite(restaurant)
    Favorite.create!(user_id: id, restaurant_id: restaurant.id)
  end

  def unfavorite(restaurant)
    Favorite.find_by(user_id: id, restaurant_id: restaurant.id).destroy
  end

  def favorite?(restaurant)
    !Favorite.find_by(user_id: id, restaurant_id: restaurant.id).nil?
  end

  private

    def downcase_email
      self.email = email.downcase
    end
end
