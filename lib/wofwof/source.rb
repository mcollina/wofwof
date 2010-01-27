module WofWof
  class Source

    attr_reader :prerequisites

    def initialize
      @prerequisites = []
    end

    def build_nodes(path_handler)
      raise NotImplementedError.new
    end
  end
end
