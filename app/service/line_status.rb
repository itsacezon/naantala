module Naantala
  module Service
    class LineStatus
      attr_reader :parser

      def initialize
        @parser = Naantala::Service::StatusParser.new(
          url: "https://dotcmrt3.gov.ph/service-status"
        )
      end

      def check_status
        puts parser.statuses
      end
    end
  end
end
