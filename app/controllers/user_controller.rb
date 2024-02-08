class UsersController < ApplicationController
    get '/users/new' do
        erb :"users/signUp.html"
    end

    post '/users' do
      user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    
      if user.save
          flash[:notice] = "Thanks for signing up! You may now log in!"
          redirect "/sessions/new"
      else
        flash.now[:errors] = user.errors.full_messages.join("; ")
        erb :"users/signUp.html"
      end
    end

    get '/sessions/new' do
      erb :"users/login.html"
    end

    post '/login' do
      user = User.find_by(:email => params[:email])
      if user && user.authenticate(params[:password])
        session[:email] = user.email
        redirect "/"
      else
        flash.now[:error] = "Invalid email or password"
        erb :"users/login.html"
      end
    end

    get '/users/signOut' do
        session[:email] = nil
        flash[:notice] = "You have been logged out."
        redirect "/"
    end
end
