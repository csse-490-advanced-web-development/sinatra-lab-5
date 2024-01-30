class User < ActiveRecord::Base
    has_secure_password
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email address" }
    validates :password_confirmation, presence: true
end

# NOTE: I created this stubbed file for you so that you have an immediate reminder that
#       you will be using has_secure_password INSTEAD OF trying to store passwords yourself!
#
