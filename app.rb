$: << File.expand_path('../', __FILE__)

require "config/environment"
require "config/initializers/rack-attack"

require "sinatra/base"
require "sinatra/flash"
require "sinatra/namespace"
require "sinatra/reloader"

require "active_model/serializers"
require "json/ext"

require "app/controllers"
require "app/models"

module Naantala
  class App < Sinatra::Application
    configure do
      disable :method_override
      enable :sessions
      set :protection, escaped_params: true
    end

    configure :development do
      register Sinatra::Reloader
    end

    register Sinatra::Namespace

    use Rack::Attack
    use Rack::Deflater

    use Naantala::Controllers::Index
    use Naantala::Controllers::Phone
  end
end

# Console access
include Naantala::Models
