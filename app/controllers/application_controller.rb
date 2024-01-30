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
    # Step 2: Enable Rack::Protection by uncommenting the following lines:
    use Rack::Protection
    use Rack::Protection::AuthenticityToken
    # removed to allow for escaping of HTML tags
    # use Rack::Protection::EscapedParams
    use Rack::Protection::FormToken
    use Rack::Protection::RemoteReferrer
    # Auth tokens: 
    # https://sinatrarb.com/protection/authenticity_token
  end

  get '/' do
    redirect "/tasks"
  end
end
