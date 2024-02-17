class UsersController < ApplicationController
    get '/users/new' do
        erb :"users/new.html"
    end

    post '/users' do
        user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
        if user.save
            flash[:notice] = "Thanks for signing up! You may now log in!"
            redirect "/sessions/new"
        else
            # for allowing the email to be retained across pages
            @email = params[:email]
            # allows errors from the validations to be pass through
            flash.now[:errors] = user.errors.full_messages.join("; ")
            erb :"users/new.html"
        end
      end
  end
  