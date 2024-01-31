class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email address"}

  has_secure_password
  validates :password_confirmation, presence: true # because apparently has_secure_password doesn't imply this validation
end
