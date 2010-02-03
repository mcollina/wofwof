
module WofWof
  class Runtime
    
    attr_reader :nodes
    attr_reader :sources
      
    def initialize
      @nodes = NodeRepository.new
      @sources = []
    end

    def render
      raise NotImplementedError.new
    end
  end
end
