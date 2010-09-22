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
      return self[@default_template] unless @default_template.nil?
      
      templates = self.select { |node| node.template? }
      if templates.size == 0
        raise "No template found!"
      elsif templates.size > 1
        # TODO replace XYZ with actual istructions.
        raise "There is more than one template found, do XYZ to specify the default one." 
      else 
        @default_template = templates.first.source_path
      end

      templates.first
    end

    def find_by_path!(search_criteria)
      result = find { |node| node.source_path =~ search_criteria }
      raise "No node found with the criteria: #{search_criteria.inspect}" unless result
      result
    end
  end
end
