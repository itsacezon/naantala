$: << File.expand_path('../', __FILE__)

require "config/environment"
require "config/initializers/rack-attack"

require "sinatra/base"
require "sinatra/reloader"

require "active_model/serializers"
require "json/ext"

require "app/controllers"
require "app/models"

module Naantala
  class App < Sinatra::Application
    configure do
      disable :method_override
      set :protection, escaped_params: true
    end

    configure :development do
      register Sinatra::Reloader
    end

    use Rack::Attack
    use Rack::Deflater

    use Naantala::Controllers::Index
  end
end

# Console access
include Naantala::Models
