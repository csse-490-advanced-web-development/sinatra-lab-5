require './config/environment'
require 'erubi'
# require 'bcrypt'


class ApplicationController < Sinatra::Application
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    logger = Logger.new(File.open("#{root}/../log/#{environment}.log", 'a'))
    logger.level = Logger::DEBUG unless production?
    set :logger, logger
    ActiveRecord::Base.logger = logger
    enable :sessions
<<<<<<< HEAD
    set :erb, :escape_html => true
=======
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
>>>>>>> ddb19a05d6e5b73062e83180580e1b4a129ae049
    # Step 2: Enable Rack::Protection by uncommenting the following lines:
    #
    use Rack::Protection
    # # `use Rack::Protection` automatically enables all modules except for the
    # # following, which have to be enabled explicitly
    use Rack::Protection::AuthenticityToken
    #use Rack::Protection::EscapedParams
    use Rack::Protection::FormToken
    use Rack::Protection::RemoteReferrer
    #
    # Implementation Note/Hint:
    #
    # You will have to update your forms to include an AuthenticityToken,
    # per the documentation for Rack::Protection::AuthenticityToken:
    # https://sinatrarb.com/protection/authenticity_token
  end

  get '/' do
    redirect "/tasks"
  end
  
end
