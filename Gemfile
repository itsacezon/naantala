source "https://rubygems.org"
ruby File.read(File.join File.dirname(__FILE__), '.ruby-version').strip

gem "sinatra"
gem "sinatra-contrib"
gem "rack-attack"
gem "rack-flash"

gem "activesupport"
gem "activemodel-serializers-xml"
gem "active_model_serializers"
gem "mongo_mapper"
gem "bson_ext"

gem "addressable"
gem "http"
gem "nokogiri"
gem "sanitize"

gem 'coveralls'

group :development do
  gem "thin"
end

group :test do
  gem "factory_girl"
  gem "faker"
  gem "rspec"
  gem "rack-test"
  gem 'database_cleaner'
end

group :staging do
  gem "puma"
end
