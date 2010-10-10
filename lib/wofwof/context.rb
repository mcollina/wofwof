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

      begin
        level = Logger.const_get(level.to_str.upcase) if level.respond_to? :to_str
      rescue NameError
        level = nil
      end

      level = Logger::ERROR if level.nil?

      @logger = Logger.new(io)
      @logger.level = level
      @logger
    end
  end
end
