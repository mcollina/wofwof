
module WofWof
  class Context
    attr_reader :configuration, :nodes

    def initialize
      @configuration = ConfigurationStore.new
      @nodes = NodeRepository.new
    end
  end
end
