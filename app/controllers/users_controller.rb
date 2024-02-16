class UsersController < ApplicationController
  get '/users/new' do
    erb :"users/new.html"
  end

  post '/users' do
    if params[:password] == params[:confirm]
      user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:confirm])
      if user.save
        flash[:notice] = "Thanks for signing up! You may now log in!"
        redirect '/sessions/new'
      else
        flash.now[:errors] = user.errors.full_messages.join("; ")
        erb :"users/new.html"
      end
    else
      flash.now[:errors] = "Password confirmation doesn't match Password"
      erb :"users/new.html"
    end
  end
end
