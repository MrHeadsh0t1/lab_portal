class User < ApplicationRecord
  has_secure_password

  has_many :todos, dependent: :destroy

  before_create :generate_auth_token

  validates :name, presence: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }

  private

  def generate_auth_token
    self.auth_token = SecureRandom.hex(24)
  end
end