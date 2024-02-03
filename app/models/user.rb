require 'bcrypt'
include BCrypt

class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: { message: "can't be blank" }, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email address" }
  validates :password, presence: { message: "can't be blank" }
  validates :password_confirmation, presence: { message: "can't be blank" }
end