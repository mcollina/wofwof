module WofWof
  class Source

    include Comparable

    attr_reader :prerequisites
    attr_reader :name

    def initialize
      @prerequisites = []
      @name = self.class.name.gsub(/^.*::(\w+)$/, '\1')
    end

    def build_nodes
      raise NotImplementedError.new
    end

    def <=>(other)
      return -1 if other.prerequisites.include? self.name
      return 1 if self.prerequisites.include? other.name
      str_cmp = self.name <=> other.name
      return str_cmp if str_cmp != 0
      return self.object_id <=> other.object_id
    end
  end
end
