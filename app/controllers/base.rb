module Naantala
  module Controllers
    class Base < Sinatra::Application
      configure do
        set :views, "app/views"
        set :root, File.expand_path("../../../", __FILE__)

        set :erb, format: :html5
      end
    end
  end
end
