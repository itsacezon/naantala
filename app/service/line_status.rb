module Naantala
  module Service
    class LineStatus
      class << self
        def check_status
          # TODO: Logging
          return unless latest_status

          if latest_status.valid?
            latest_status.save!
            notify(latest_status)
          end
        end

        private

        def latest_status
          @latest_status ||= Naantala::Service::StatusParser
            .statuses("https://dotcmrt3.gov.ph/service-status")
            .first
        end

        def notify(status)
          Naantala::Service::Notifier.notify_subscribers!(status)
        end
      end
    end
  end
end
