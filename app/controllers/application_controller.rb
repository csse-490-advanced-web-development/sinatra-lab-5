require './config/environment'
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
    set :erb, :escape_html => true
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }

    use Rack::Protection
    # `use Rack::Protection` automatically enables all modules except for the
    # following, which have to be enabled explicitly
    use Rack::Protection::AuthenticityToken
    # use Rack::Protection::EscapedParams # erubi is handling html escaping
    use Rack::Protection::FormToken
    use Rack::Protection::RemoteReferrer
  end

  get '/' do
    redirect "/tasks"
  end

  helpers do
    def hattr(text)
      Rack::Utils.escape_path(text.to_s)
    end
  end
end
