class UsersController < ApplicationController
    get '/users/new' do
      erb :"users/new.html", locals: { user: User.new }
    end
    
  
    post '/users' do
      user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
      #session[:sign_up_email] = nil
      if user.save
        flash[:notice] = "Thanks for signing up! You may now log in!"
        redirect "/sessions/new"
      else
        #session[:sign_up_email] = params[:email]
        flash[:errors] = user.errors.full_messages.join("; ")
        erb :"users/new.html"

      end
    end
  end