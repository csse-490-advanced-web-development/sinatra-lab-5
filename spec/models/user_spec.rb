require_relative "../spec_helper"

describe "User" do
  describe "#create" do
    describe "with valid data" do
      before do
        User.count.should eq 0  # Sanity check that we haven't got orphaned records hanging around
        User.create!(email: 'eliza@example.com', password: 'Password1', password_confirmation: 'Password1')
      end

      it "should create a user" do
        User.count.should be 1
      end

      it "should save the email we passed in" do
        User.first.email.should eq 'eliza@example.com'
      end
    end

    describe "without a email" do
      let(:user){ User.new }
      before { user.save }

      it { user.should_not be_valid }
      it { user.errors[:email].should include "can't be blank" }
      it { user.errors[:password].should include "can't be blank" }
      it { user.errors[:password_confirmation].should include "can't be blank" }
    end

    describe "with mismatched passwords" do
      let(:user){ User.new(email: "marilyn@example.com", password: "I am a password", password_confirmation: "So am I!") }
      before { user.save }

      it { user.should_not be_valid }
      it { user.errors[:password_confirmation].should include "doesn't match Password" }
      # Hint: https://guides.rubyonrails.org/active_record_validations.html#confirmation
    end

    describe "with a non-email" do
      let(:user){ User.new(email: "foo@    ") }
      before { user.save }

      it { user.should_not be_valid }
      it { user.errors[:email].should include "is not a valid email address" }
      # Hint: `validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email address" }`
    end
  end
end