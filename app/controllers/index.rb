module Naantala
  module Controllers
    class Index < Base
      get "/" do
        erb :index
      end

      post "/phone/new" do
        escaped = ERB::Util.html_escape(params[:number])

        # Check format
        number =
          if escaped.starts_with?("09")
            "+63#{escaped[1..-1]}"
          elsif escaped.starts_with?("+63")
            escaped
          else
            "+63#{escaped}"
          end

        model = Models::PhoneNumber.new(number: number)

        if model.valid?
          model.save!
        end

        redirect "/"
      end
    end
  end
end
