module WofWof
  class NodeRepository

    include Enumerable

    attr_reader :configuration

    def initialize
      @hash = {}
      @default_template = nil
      @configuration = ConfigurationStore.new(self)
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

    def find_by_path!(search_criteria)
      result = find { |node| node.source_path =~ search_criteria }
      raise "No node found with the criteria: #{search_criteria.inspect}" unless result
      result
    end
  end
end
