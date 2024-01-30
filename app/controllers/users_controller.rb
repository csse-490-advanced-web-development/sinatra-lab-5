class UsersController < ApplicationController
  get '/users/new' do
    @user = User.new
    erb :"users/new.html"
  end

  post '/users' do
    @user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:confirm])

    if @user.save
      flash[:notice] = "Thanks for signing up! You may now log in!"
      redirect "/sessions/new"
    else
      flash.now[:errors] = @user.errors.full_messages.join("; ")
      erb :"users/new.html"
    end
  end

  get '/sessions/new' do
    @user = User.new
    erb :"sessions/new.html"
  end

  post '/sessions' do
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      flash[:notice] = "You are logged in as #{@user.email}"
      session[:user_id] = @user.id
      redirect "/"
    else
      flash.now[:errors] = "Invalid email or password"
      erb :"sessions/new.html"
    end
  end

  get '/sessions/destroy' do
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect "/"
  end
end