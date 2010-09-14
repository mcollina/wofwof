module WofWof
  class NodeRepository

    include Enumerable

    def initialize
      @hash = {}
      @default_template = nil
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

    def default_template=(template)
      store(template)
      @default_template = template.source_path
      template
    end

    def default_template
      self[@default_template]
    end
  end
end
