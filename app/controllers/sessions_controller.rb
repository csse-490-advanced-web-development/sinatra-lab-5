class SessionsController < ApplicationController
  get '/sessions/new' do
    erb :"sessions/new.html"
  end

  post '/sessions' do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/"
    else
      flash.now[:error] = "Invalid email or password"
      erb :"sessions/new.html"
    end
  end
end
