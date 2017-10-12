require "nokogiri"
require "open-uri"

status_url = "https://dotcmrt3.gov.ph/service-status"
status_page = Nokogiri::HTML(open(status_url))
status_tables = status_page.at(".service-status-page")

puts status_tables
