require './config/environment'
require 'erubi'

set :erb, :escape_html => true


class ApplicationController < Sinatra::Application
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    logger = Logger.new(File.open("#{root}/../log/#{environment}.log", 'a'))
    logger.level = Logger::DEBUG unless production?
    set :logger, logger
    ActiveRecord::Base.logger = logger
    enable :sessions
  end

  get '/' do
    redirect "/tasks"
  end
end
