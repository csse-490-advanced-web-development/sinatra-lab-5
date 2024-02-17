require './config/environment'
require 'rack/protection'
require 'erubi'

class ApplicationController < Sinatra::Application
  configure do
    set :erb, :escape_html => true
    set :public_folder, 'public'
    set :views, 'app/views'
    logger = Logger.new(File.open("#{root}/../log/#{environment}.log", 'a'))
    logger.level = Logger::DEBUG unless production?
    set :logger, logger
    ActiveRecord::Base.logger = logger
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }

    use Rack::Protection
    use Rack::Protection::AuthenticityToken
    use Rack::Protection::EscapedParams
    use Rack::Protection::FormToken
    use Rack::Protection::RemoteReferrer
  end

  get '/' do
    redirect "/tasks"
  end

  post '/sessions/signout' do
    session[:user_id] = nil
    puts("SIGN OUT")
    flash[:notice] = "You have been signed out."
    redirect "/"
  end
