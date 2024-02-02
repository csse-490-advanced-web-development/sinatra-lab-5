# require './config/environment'

class SessionController < ApplicationController

  get '/sessions/new' do
    erb :"sessions/new.html"
  end

  post '/sessions' do
    user = User.find_by(email: params[:email])


    if user&.authenticate(params[:password])
      flash[:notice] = "You are logged in as #{user.email}"
      redirect "/"
    else
      flash.now[:errors] = "Invalid email or password"
      erb :"sessions/new.html"
    end
  
    end

  end
