require 'logger'

module WofWof
  class Context
    attr_reader :configuration, :nodes

    def initialize
      @configuration = ConfigurationStore.new
      @nodes = NodeRepository.new
      @logger = nil
    end

    def logger
      return @logger unless @logger.nil?

      io = @configuration.log_io
      io = STDOUT if io.nil?

      level = @configuration.log_level
      level = Logger::FATAL if level.nil?

      @logger = Logger.new(io)
      @logger.level = level
      @logger
    end
  end
end
