class SessionsController < ApplicationController
    get '/sessions/new' do
        erb :"sessions/new.html"
    end

    post '/sessions' do
        user = User.find_by(email: params[:email])
        if user.authenticate(params[:password])
            flash[:notice] = "You are logged in as " + params[:email]
            session[:user_id] = user.id
	        redirect "/"
        else 
            @email = params[:email]
            @error = "Invalid email or password"
            flash.now[:errors] = user.errors.full_messages.join("; Invalid email or password")
            erb :"sessions/new.html"
        end
    end

    get '/sessions/logout' do
        session.clear
        flash[:notice] = "You have been logged out."
        redirect '/' 
    end
  end