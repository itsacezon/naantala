require "app/models/phone_number"

module Naantala
  module Service
    class Notifier
      class << self
        def notify_subscribers!(status)
          phone_numbers = Naantala::Models::PhoneNumber.all(confirmed: true)

          service_status = build_message(status)
          phone_numbers.collect(&:number).each do |number|
            client.account.messages.create(
              from: ENV["TWILIO_NUMBER"],
              to: number,
              body: service_status
            )
            # TODO: Logging
          end
        end

        def build_message(status)
          message = status.description
          downcased = message.downcase

          # If description does not have station and time, include them

          station_tokens = status.station.downcase.gsub("-", "").split
          has_station = station_tokens.any? { |token| downcased.include? token }
          unless has_station
            message = "#{message} Station: #{status.station}"
          end

          time_string = status.time.strftime("%l:%M %p").strip
          unless downcased.include? time_string.downcase
            message = "#{message}#{',' unless has_station} Time: #{time_string}"
          end

          "SERVICE STATUS: #{message}"
        end

        private

        def client
          @client ||= Twilio::REST::Client.new(
            ENV["TWILIO_ACCOUNT_SID"],
            ENV["TWILIO_AUTH_TOKEN"]
          )
        end
      end
    end
  end
end
