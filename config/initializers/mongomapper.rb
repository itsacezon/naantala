options = {
  logger: NaantalaLogger.log,
  pool_size: 30,
  pool_timeout: 5
}

config_file = "#{File.dirname(__FILE__)}/../mongodb.yml"
MongoMapper.config = YAML.load(ERB.new(File.read(config_file)).result)
MongoMapper.setup(MongoMapper.config, ENV["RACK_ENV"], options)

puts "Initialized: #{MongoMapper.database.name}"
