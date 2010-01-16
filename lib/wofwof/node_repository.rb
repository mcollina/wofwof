module WofWof
  class NodeRepository

    include Enumerable

    def initialize
      @hash = {}
    end

    alias :all :entries

    def each(&block)
      @hash.each_value(&block)
    end

    def [] key
      @hash[key]
    end

    def store node
      @hash[node.source_path] = node
    end

    def unstore node
      @hash.delete(node.source_path)
    end
  end
end
