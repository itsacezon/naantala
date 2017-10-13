require "rubygems"
require "bundler/setup"

Bundler.require

# Initialize database
conf = JSON.parse(File.read("./config/db.json"))
MongoMapper.setup(conf["connection"], Sinatra::Base.environment)
