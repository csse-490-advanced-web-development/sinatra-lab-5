class SessionsController < ApplicationController
    get '/sessions/new' do
      erb :"sessions/new.html"
    end

    post '/sessions' do
      user = User.find_by(:email => params[:email])
      if user && user.authenticate(params[:password])
          session[:email] = user.email
          flash[:notice] = "Thanks for loging in : " + user.email
          redirect to "/"
      else
          flash[:error] =  "Your Credentials are invalid please sign up or try again."
          redirect to "/sessions/new"
      end
    end
end
