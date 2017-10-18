module Naantala
  module Controllers
    class Index < Base
      get "/" do
        erb :index
      end
    end
  end
end
