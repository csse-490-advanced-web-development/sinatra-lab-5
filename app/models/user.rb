class User < ActiveRecord::Base
  has_secure_password
#   it { user.should_not be_valid }
#   it { user.errors[:email].should include "can't be blank" }
#   it { user.errors[:password].should include "can't be blank" }
#   it { user.errors[:password_confirmation].should include "can't be blank" }
    validates :email, presence: {message: "can't be blank"}
    validates :password, presence: {message: "can't be blank"}
    validates :password_confirmation, presence: {message: "can't be blank"}
end

# NOTE: I created this stubbed file for you so that you have an immediate reminder that
#       you will be using has_secure_password INSTEAD OF trying to store passwords yourself!
#
