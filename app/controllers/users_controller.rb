# require './config/environment'

class UsersController < ApplicationController

  get '/users/new' do
    erb :"users/new.html"
  end

  post '/users' do

      user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
      if user.save
        flash.now[:notice] = "Thanks for signing up! You may now log in!"

        redirect '/sessions/new'
      else
      # so what your typed for email can stay even if you get the password/confirmed passwd wrong  
        @email = params[:email]
        flash.now[:errors] = user.errors.full_messages.join("; ")

        erb :"users/new.html"
        end
    end



  end
