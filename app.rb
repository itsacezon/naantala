require "rack"
require "sinatra/base"

module Naantala
  class App < Sinatra::Application
    configure do
      disable :method_override
      disable :static
    end

    use Rack::Deflater
  end
end
