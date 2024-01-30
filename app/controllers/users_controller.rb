class UsersController < ApplicationController
    get '/users/new' do
	erb :"users/new.html"
    end
end
