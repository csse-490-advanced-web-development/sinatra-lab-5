class SessionsController < ApplicationController
    get '/sessions/new' do
      erb :"user/signin.html"
    end
  
    post '/sessions' do
      user = User.find_by(email: params[:Email])
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:notice] = "You are logged in as #{user.email}"
        redirect "/"
      else
        flash.now[:errors] = "Invalid email or password"
        erb :"user/signin.html", locals: {user: user}
      end
    end

    delete '/sessions' do
        session[:user_id] = nil
        flash[:notice] = "You have been logged out."
        redirect "/"
    end
  
  end