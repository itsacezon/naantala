env = ENV["RACK_ENV"] || Sinatra::Base.environment

logger = Logger.new(File.join(File.dirname(__FILE__), "/../../log/db-#{env}.log"), "daily")
logger.formatter = Logger::Formatter.new
logger.datetime_format = "%H:%M:%S %Y-%m-%d"

options = {
  logger: logger,
  pool_size: 30,
  pool_timeout: 5
}

config_file = "#{File.dirname(__FILE__)}/../mongodb.yml"
MongoMapper.config = YAML.load(ERB.new(File.read(config_file)).result)
MongoMapper.setup(MongoMapper.config, env, options)
MongoMapper.connection.instance_variable_set(:@logger, logger)

if env == "production"
  logger.level = Logger::Severity::INFO
  MongoMapper.connection.logger.level = Logger::Severity::INFO
end

puts "Initialized: #{MongoMapper.database.name}"
