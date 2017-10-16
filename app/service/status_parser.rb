require "open-uri"
require "app/models/status"

module Naantala
  module Service
    class StatusParser
      class << self
        def statuses(url)
          @url = url
          raw_statuses.map { |r|
            Naantala::Models::Status.new(r)
          }
        end

        private

        def page
          Nokogiri::HTML(open(@url))
        end

        def parse(section)
          date = section.at(".news-main-title").text
          section.css("table tbody tr").map do |row|
            cells = row.css("td").map(&:text).map(&:strip)
            {
              time: Time.parse("#{date} #{cells[0]} +0800"),
              description: cells[1],
              status: cells[2],
              station: cells[3],
              bound: cells[4]
            }
          end
        end

        def raw_statuses
          selector = ".service-status-page .news-main-item"
          page.css(selector)
            .flat_map { |section| parse(section) }
            .sort_by { |status| status[:time] }
            .reverse!
        end
      end
    end
  end
end
