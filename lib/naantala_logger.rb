require "logger"

class NaantalaLogger
  def self.log
    if @logger.nil?
      @logger = Logger.new(
        File.join(File.dirname(__FILE__), "/../log/#{ENV["RACK_ENV"]}.log"),
        "daily"
      )
      @logger.level = ENV["RACK_ENV"] == "production" ? Logger::Severity::INFO : Logger::Severity::DEBUG
      @logger.formatter = proc { |severity, datetime, progname, msg|
        "[#{datetime.strftime("%H:%M:%S %Y-%m-%d")}] #{severity} (#{progname}): #{msg}\n"
      }
      @logger.progname = "Naantala"
    end
    @logger
  end
end
