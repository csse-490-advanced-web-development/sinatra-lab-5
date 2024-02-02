# require './config/environment'

class SessionController < ApplicationController

  get '/sessions/new' do
    erb :"sessions/new.html"
  end

  post '/sessions' do
    redirect "/"
    end

  end
