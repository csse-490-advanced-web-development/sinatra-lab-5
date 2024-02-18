class SessionsController < ApplicationController
    get '/sessions/new' do
      erb :"sessions/new.html"
    end
end