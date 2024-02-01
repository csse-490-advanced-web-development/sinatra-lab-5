# require './config/environment'

class UsersController < ApplicationController

  get '/users/new' do
    erb :"users/new.html"
  end

  post '/users' do

    # describe "with mismatched passwords" do
    #   let(:user){ User.new(email: "marilyn@example.com", password: "I am a password", password_confirmation: "So am I!") }
    #   before { user.save }

    #   it { user.should_not be_valid }
    #   it { user.errors[:password_confirmation].should include "doesn't match Password" }
    #   # Hint: https://guides.rubyonrails.org/active_record_validations.html#confirmation
    # end

    # describe "with a non-email" do
    #   let(:user){ User.new(email: "foo@    ") }
    #   before { user.save }

    #   it { user.should_not be_valid }
    #   it { user.errors[:email].should include "is not a valid email address" }
    #   # Hint: `validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email address" }`
    # end

    #if the password == confirmed password
    if params[:password] == params[:confirm]

      user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:confirm])
      if user.save
        flash[:notice] = "Thanks for signing up! You may now log in!"
        redirect '/sessions/new'
      else
        flash.now[:errors] = user.errors.full_messages.join("; ")
        erb :"users/new.html"
        end
    #if not,    
    else
      flash.now[:errors] = "doesn't match Password"
      erb :"users/new.html"
      end
    end



  end
