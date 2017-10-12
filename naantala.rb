require "sinatra"

set :erb, :format => :html5

get "/" do
  erb :index
end
