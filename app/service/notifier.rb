require "lib/semaphore_api"
require "app/models/phone_number"

module Naantala
  module Service
    class Notifier
      class << self
        def notify_subscribers!(status)
          phone_numbers = Naantala::Models::PhoneNumber.all(confirmed: true)

          service_status = build_message(status)
          numbers_string = phone_numbers.join(",").gsub("+63", "0")
          client.send_message(
            message: service_status,
            numbers: numbers_string
          )
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

          "MRT3 SERVICE STATUS: #{message}"
        end

        private

        def client
          @client ||= SemaphoreApi.new
        end
      end
    end
  end
end
