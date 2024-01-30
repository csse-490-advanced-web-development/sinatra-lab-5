class SessionsController < ApplicationController
    get '/sessions/new' do
        erb :"sessions/new.html"
    end

    post '/sessions' do
        user = User.find_by(email: params[:email])
        if(user.authenticate(params[:password]))
            flash[:notice] = "You are logged in as " + params[:email]
	        redirect "/"
        else 
            # allows errors from the validations to be pass through
            flash.now[:errors] = user.errors.full_messages.join("; ")
            erb :"sessions/new.html"
        end



    end
  end
