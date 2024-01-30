class UserController < ApplicationController
  get '/users/new' do
    erb :"user/signup.html"
  end

  post '/users/new' do
    user = User.new(email: params[:email], password_digest: params[:password])
    if user.save
      flash[:notice] = "Thanks for signing up! You may now log in!"
      redirect "/"
    end
  end

end
