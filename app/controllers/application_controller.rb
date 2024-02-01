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
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
    # Step 2: Enable Rack::Protection by uncommenting the following lines:
    #
    use Rack::Protection
    use Rack::Protection::AuthenticityToken
    # use Rack::Protection::EscapedParams breaks escaped params
    use Rack::Protection::FormToken
    use Rack::Protection::RemoteReferrer
  end

  get '/' do
    redirect "/tasks"
  end

  helpers do
    def current_user
      User.find_by(id: session[:user_id])
    end
  end
end
