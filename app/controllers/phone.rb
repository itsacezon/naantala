require "securerandom"
require "lib/semaphore_api"

module Naantala
  module Controllers
    class Phone < Base
      namespace "/phone" do
        before "/*" do
          escaped = Sanitize.fragment(params[:number] || session[:code])
          @number = format_e164(escaped.gsub(/\s+/, ""))
        end

        post "/new" do
          redirect "/" if has_reached_limit

          code = SecureRandom.hex(4)
          model = Models::PhoneNumber.new(
            number: @number,
            code: code
          )

          if model.valid?
            # model.save!
            # response = SemaphoreApi.send_message(
            #   message: confirm_message(@number.gsub("+63", ""), code),
            #   number: @number
            # )
            session[:code] = code
            redirect "/phone/confirm"
          else
            flash[:error] = model.errors.full_messages.join(",")
          end

          redirect "/"
        end

        get "/confirm" do
          code = Sanitize.fragment(params[:code] || session[:code])
            .gsub(/\s+/, "")
          puts code, @number
        end
      end

      helpers do
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
          "Your verification code is: #{code}. To confirm, go to"\
          " https://naantala.com/phone/confirm?number=#{number}&code=#{code}"
        end
      end
    end
  end
end
