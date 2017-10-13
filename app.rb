$: << File.expand_path('../', __FILE__)

require "dotenv"
Dotenv.load

require "rack"
require "sinatra/base"
require "sinatra/reloader"

require "active_model/serializers"
require "mongo_mapper"
require "json/ext"

require "app/controllers"
require "app/models"

module Naantala
  class App < Sinatra::Application
    configure do
      disable :method_override
      set :protection, escaped_params: true

      db_config = JSON.parse(File.read("./config/db.json"))
      MongoMapper.setup(
        db_config["connection"],
        ENV["ENVIRONMENT"]
      )
    end

    configure :development do
      register Sinatra::Reloader
    end

    use Rack::Deflater

    use Naantala::Controllers::Index
  end
end

# Console access
include Naantala::Models
