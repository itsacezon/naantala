require "sinatra/base"

class Naantala < Sinatra::Base
  set :erb, :format => :html5

  get "/" do
    erb :index
  end

  run! if app_file == $0
end
