class TasksController < ApplicationController
  get '/users/new' do
    @user = User.new
    erb :"users/new.html"
  end

  post '/users' do
    @user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:confirm])

    if @user.save
      flash[:notice] = "Thanks for signing up! You may now log in!"
      redirect "/"
    else
      flash.now[:errors] = @user.errors.full_messages.join("; ")
      erb :"users/new.html"
    end
  end
end