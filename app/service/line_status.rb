require "app/models"

module Naantala
  module Service
    class LineStatus
      class << self
        def check_status
          latest = parser.statuses.first

          status = Naantala::Models::Status.new(
            time: latest[:time],
            description: latest[:description],
            status: latest[:status],
            station: latest[:station],
            bound: latest[:bound]
          )

          return unless status.valid?

          status.save!

          # NOTE: For now, limit this to 1000 on Twilio
          phone_numbers = Naantala::Models::PhoneNumbers.all.collect(&:number)

          notifier = Naantala::Service::Notifier.new(
            phone_numbers: phone_numbers,
            status: status
          )
          notifier.send!
        end

        private

        def parser
          @parser ||= Naantala::Service::StatusParser.new(
            url: "https://dotcmrt3.gov.ph/service-status"
          )
        end
      end
    end
  end
end
