class User < ApplicationRecord
  has_secure_token :access_token
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP}
end
