require "app/models/phone_number"

module Naantala
  module Service
    class Notifier
      class << self
        def notify_subscribers!(status)
          @phone_numbers = Naantala::Models::PhoneNumber.all
          @status = status

          puts "Sent!"
        end

        private

        def client
          @client ||= Twilio::REST::Client.new()
        end

        def build_message

        end
      end
    end
  end
end
