class TasksController < ApplicationController
    get '/users/new' do
      erb :"users/new.html"
    end

    post '/users/new' do
        user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:confirm])

        # if params[:email].empty? do
        #    flash.now[:alert] = "Email can't be blank" 
        # end

        if user.save
            flash[:notice] = "Thanks for signing up! You may now log in!"
            redirect "/"
        else
            flash.now[:errors] = user.errors.full_messages.join("; ")
            erb :"users/new.html", locals: {user: user}
        end
    end
  
end
  