class User < ApplicationRecord
  has_secure_password(validations: false)

  validates :email, presence: true
  normalizes :email, with: ->(email) {email.strip.downcase}

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  generates_token_for :email_confirmation, expires_in: 24.hours do
    email
  end
end
