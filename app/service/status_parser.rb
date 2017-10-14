require "date"
require "open-uri"

module Naantala
  module Service
    class StatusParser
      attr_reader :url

      def initialize(params = {})
        @url = params.fetch(:url, "")
      end

      def statuses
        selector = ".service-status-page .news-main-item"
        page.css(selector)
          .flat_map { |section| parse_data(section) }
          .sort_by { |status| status[:time] }
          .reverse!
      end

      private

      def page
        Nokogiri::HTML(open(url))
      end

      def parse_data(section)
        date = section.at(".news-main-title").text
        section.css("table tbody tr").map do |row|
          cells = row.css("td").map(&:text).map(&:strip)
          {
            time: DateTime.parse("#{date} #{cells[0]} +0800"),
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
