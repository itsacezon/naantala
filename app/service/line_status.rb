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

          # TODO: Logging
          return unless status.valid?

          status.save!

          phone_numbers = Naantala::Models::PhoneNumber.all.collect(&:number)

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
