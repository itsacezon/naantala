require "securerandom"

module Naantala
  module Controllers
    class Phone < Base
      def confirmation_message(code)
        "Thanks for subscribing! To confirm, visit https://naantala.com/phone/confirm?code=#{code}"
      end

      namespace "/phone" do
        post "/new" do
          escaped = ERB::Util.html_escape(params[:number])
            .gsub(/\s+/, "")

          # Check format
          number =
            if escaped.starts_with?("09")
              "+63#{escaped[1..-1]}"
            elsif escaped.starts_with?("+63")
              escaped
            else
              "+63#{escaped}"
            end

          code = SecureRandom.base64(48)
          model = Models::PhoneNumber.new(
            number: number,
            confirmation_code: code
          )

          if model.valid?
            model.save!
          else
            model.errors.full_messages
          end

          redirect "/"
        end

        get "/confirm" do
          puts params[:code]
        end
      end
    end
  end
end
