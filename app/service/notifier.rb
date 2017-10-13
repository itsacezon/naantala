require "twilio-ruby"

module Naantala
  module Service
    class Notifier
      attr_reader :message, :phone_numbers

      def initialize(params = {})
        @message = params.fetch(:message, "")
        @phone_numbers = params.fetch(:phone_numbers, [])
      end

      private

      def client
        @client ||= Twilio::REST::Client.new()
      end
    end
  end
end
