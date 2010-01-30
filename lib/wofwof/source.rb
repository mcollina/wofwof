module WofWof
  class Source

    include Comparable

    attr_reader :prerequisites
    attr_reader :name

    def initialize
      @prerequisites = []
      @name = self.class.name.gsub(/^.*::(\w+)$/, '\1')
    end

    def build_nodes(path_handler)
      raise NotImplementedError.new
    end

    def <=>(other)
      return -1 if other.prerequisites.include? self.name
      return 1 if self.prerequisites.include? other.name
      return self.name <=> other.name
    end
  end
end
