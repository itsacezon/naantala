require "lib/semaphore_api"
require "app/models/phone_number"

module Naantala
  module Service
    class Notifier
      class << self
        def notify_subscribers!(status)
          numbers = Naantala::Models::PhoneNumber.all(confirmed: true)

          message = build_message(status)
          numbers_string = numbers.collect(&:number).join(",")

          NaantalaLogger.log.info "#{message}"

          if client.send_message(message: message, numbers: numbers_string)
            NaantalaLogger.log.info "NOTIFIER: Sent status to #{numbers.size} subscribers"
          else
            NaantalaLogger.log.info "NOTIFIER: Failed to send status. Check Semaphore logs."
          end
        end

        def build_message(status)
          message = status.description
          downcased = message.downcase

          # If description does not have station and time, include them.
          # Sometimes, the description won't match the attribute on the table
          # e.g. time mismatch; in this case, the description will be followed

          station_tokens = status.station.downcase.gsub("-", "").split
          has_station = station_tokens.any? { |token| downcased.include? token }
          unless has_station
            message = "#{message} Station: #{status.station}"
          end

          begin
            # Test if the description contains a time
            Time.parse(downcased)
          rescue ArgumentError
            time_string = status.time.strftime("%l:%M %p").strip
            message = "#{message}#{',' unless has_station} Time: #{time_string}"
          end

          "MRT-3 STATUS: #{message}"
        end

        private

        def client
          @client ||= SemaphoreApi.new
        end
      end
    end
  end
end
