require './config/environment'
require 'rack/protection'
require 'erubi'

class ApplicationController < Sinatra::Application
  configure do
    set :erb, escape_html: true
    set :public_folder, 'public'
    set :views, 'app/views'
    logger = Logger.new(File.open("#{root}/../log/#{environment}.log", 'a'))
    logger.level = Logger::DEBUG unless production?
    set :logger, logger
    ActiveRecord::Base.logger = logger
    enable :sessions
    set :erb, :escape_html => true
    use Rack::Protection
    # `use Rack::Protection` automatically enables all modules except for the
    # following, which have to be enabled explicitly
    use Rack::Protection::AuthenticityToken
    use Rack::Protection::FormToken
    use Rack::Protection::RemoteReferrer
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  end

  get '/' do
    redirect "/tasks"
  end
end
