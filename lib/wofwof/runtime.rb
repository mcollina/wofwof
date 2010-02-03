
module WofWof
  class Runtime
    
    attr_reader :nodes
      
    def initialize
      @nodes = NodeRepository.new
    end

    def register(path_handler, source_name)
      raise NotImplementedError.new
    end

    def sources
      raise NotImplementedError.new
    end

    def render
      raise NotImplementedError.new
    end
  end
end
