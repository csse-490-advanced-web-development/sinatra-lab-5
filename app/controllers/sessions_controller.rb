class SessionsController < ApplicationController
    get '/sessions/new' do
      erb :"sessions/new.html"
    end

    post '/sessions/login' do
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:notice] = "You are logged in as #{user.email}"
            redirect "/"
        else
            flash.now[:error] = "Invalid email or password"
            erb :"sessions/new.html", locals: {email: params[:email]}
        end
    end

    post '/sessions/logout' do
        session.clear
        flash[:notice] = "You have been logged out."
        redirect "/"
    end
end