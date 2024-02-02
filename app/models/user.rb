class User < ActiveRecord::Base
  has_secure_password
    validates :email, presence: {message: "can't be blank"}
    validates :password, presence: {message: "can't be blank"}, confirmation: true
    validates :password_confirmation, presence: {message: "can't be blank"}
end

# NOTE: I created this stubbed file for you so that you have an immediate reminder that
#       you will be using has_secure_password INSTEAD OF trying to store passwords yourself!
#
