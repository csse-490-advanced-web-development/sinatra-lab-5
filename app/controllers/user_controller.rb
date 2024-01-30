class UsersController < ApplicationController
    get '/users/new' do
        erb :"users/signUp.html"
    end

    post '/users' do
        user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    
        if user.save
            flash[:notice] = "Thanks for signing up! You may now log in!"
            redirect "/"
        else
          flash.now[:errors] = user.errors.full_messages.join("; ")
          erb :"users/signUp.html"
        end
      end
end
