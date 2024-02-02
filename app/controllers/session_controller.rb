# require './config/environment'

class SessionController < ApplicationController

  get '/sessions/new' do
    erb :"sessions/new.html"
  end

  post '/sessions' do
    user = User.find_by(email: params[:email])


    if user&.authenticate(params[:password])
      session[:loggedin] = params[:email]
      flash[:notice] = "You are logged in as #{user.email}"
      redirect "/"
    else
      @email = params[:email]
      flash.now[:errors] = "Invalid email or password"
      erb :"sessions/new.html"
    end
  
  end
  delete '/sessions' do
    session[:loggedin] = nil
    flash[:notice] = "You have been logged out."
    redirect "/"
  end



end

