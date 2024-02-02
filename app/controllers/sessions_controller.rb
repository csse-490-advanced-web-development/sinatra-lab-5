class SessionsController < ApplicationController
    get '/sessions/new' do
      email = session[:sign_in_email] || ""
      session[:sign_in_email] = nil
      erb :"sessions/new.html", locals: {email: email}
    end
  
    post '/sessions' do
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/"
      else
        session[:sign_in_email] = params[:email]
        flash[:errors] = "Invalid email or password"
        redirect "/sessions/new"
      end
    end
  
    delete '/sessions' do
      if session[:user_id] then
        session[:user_id] = nil
        flash[:notice] = "You have been logged out."
      end
      redirect "/"
    end
  end