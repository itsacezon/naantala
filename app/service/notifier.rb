require "twilio-ruby"

module Naantala
  module Service
    class Notifier
      attr_accessor :phone_numbers, :status

      def initialize(params = {})
        @phone_numbers = params.fetch(:phone_numbers, [])
        @status = params.fetch(:status)
      end

      def send!
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
