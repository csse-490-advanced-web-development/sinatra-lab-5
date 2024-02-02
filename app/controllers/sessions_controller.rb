class SessionsController < ApplicationController
    get '/sessions/new' do
        erb :"sessions/new.html"
    end

    post '/sessions' do
        user = User.find_by(email: params[:email])
        if(user.authenticate(params[:password]))
            flash[:notice] = "You are logged in as " + params[:email]
            session[:user_id] = user.id
	        redirect "/"
        else 
            # for allowing the email to be retained across pages
            @email = params[:email]
            @error = "Invalid email or password"
            # allows errors from the validations to be pass through
            flash.now[:errors] = user.errors.full_messages.join("; Invalid email or password")
            erb :"sessions/new.html"
        end
    end

    get '/sessions/signout' do
        session[:user_id] = nil
        flash[:notice] = "You have been logged out."
        redirect "/"
    end
  end
