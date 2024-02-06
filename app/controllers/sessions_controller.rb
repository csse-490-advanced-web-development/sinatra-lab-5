class SessionsController < ApplicationController
    get '/sessions/new' do
	erb :"sessions/new.html"
    end
    post '/sessions' do
	@user = User.find_by(email: params[:email])
	@email = params[:email]
	@logged_in = false
	if @user && @user.authenticate(params[:password])
	    session[:user_id] = @user.id
	    flash[:notice] = "You are logged in as " + params[:email]
	    redirect "/"
	else
	   flash.now[:error] = "Invalid email or password"
	    erb :"sessions/new.html"
	end
    end

    get '/sessions/delete' do
	session.delete(:user_id)
	flash[:notice] = "You have been logged out."
	redirect "/"
    end
end
