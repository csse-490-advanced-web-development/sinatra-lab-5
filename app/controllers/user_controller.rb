class UserController < ApplicationController
  get '/users/new' do
    erb :"user/signup.html"
  end

  post '/users/new' do
    user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:confirmPassword])
    if user.save
      flash[:notice] = "Thanks for signing up! You may now log in!"
      redirect "/"
    else
      flash.now[:errors] = user.errors.full_messages.join("; ")
      erb :"user/signup.html", locals: {user: user}
    end
  end

end
