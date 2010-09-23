
module WofWof
  class ConfigurationStore

    attr_reader :node_repository

    def initialize(node_repository)
      @node_repository = node_repository
    end

    def default_template=(template)
      node_repository.store(template)
      @default_template = template.source_path
      template
    end

    def default_template
      return node_repository[@default_template] unless @default_template.nil?
      
      templates = node_repository.select { |node| node.template? }
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
  end
end
