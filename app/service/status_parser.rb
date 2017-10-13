require "date"
require "nokogiri"
require "open-uri"

module Naantala
  module Service
    class StatusParser
      attr_reader :url

      def initialize(params = {})
        @url = params.fetch(:url, "http://example.com")
      end

      def statuses
        selector = ".service-status-page .news-main-item"

        # NOTE: Data is already sorted from the page
        # In case of change, apply necessary sort method
        page.css(selector).flat_map { |section| parse_data(section) }
      end

      private

      def page
        Nokogiri::HTML(open(url))
      end

      def time_in_manila(date)
        DateTime.parse(date).new_offset("+0800")
      end

      def parse_data(section)
        date = section.at(".news-main-title").text
        section.css("table tbody tr").map do |row|
          cells = row.css("td").map(&:text).map(&:strip)
          {
            time: time_in_manila("#{date} #{cells[0]}"),
            description: cells[1],
            status: cells[2],
            station: cells[3],
            bound: cells[4]
          }
        end
      end
    end
  end
end
