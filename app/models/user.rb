class User < ActiveRecord::Vase
    has_secure_password
    validates :email, presence:true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
    validates :password_confirmation, presence: true
end