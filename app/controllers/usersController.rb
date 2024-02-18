class UsersController < ApplicationController
    get '/users/new' do
      erb :"users/new.html"
    end
  
    post '/usersSignup' do
        user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:checkPass])
    
        if user.save #if things check out for the new account 
            flash[:notice] = "Thanks for signing up! You may now log in!"
            redirect "/"
        else
            #say theres an error
            flash[:notice] = "Sign Up failed"
            redirect "users/new"

        end
    end
end