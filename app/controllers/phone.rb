require "securerandom"

module Naantala
  module Controllers
    class Phone < Base
      def format_e164(number)
        if number.starts_with?("09")
          "+63#{number[1..-1]}"
        elsif number.starts_with?("+63")
          number
        else
          "+63#{number}"
        end
      end

      def confirm_message(number, code)
        "Thanks for subscribing! To confirm, visit"\
        " https://naantala.com/phone/confirm?"\
        "number=#{number}&code=#{code}"
      end

      namespace "/phone" do
        post "/new" do
          escaped = Sanitize.fragment(params[:number])
            .gsub(/\s+/, "")

          number = format_e164(escaped)
          code = SecureRandom.hex(4)

          model = Models::PhoneNumber.new(
            number: number,
            code: code
          )

          if model.valid?
            puts confirm_message(number.gsub("+63", ""), code)
            # model.save!
          else
            puts "#{model.errors.full_messages}"
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
