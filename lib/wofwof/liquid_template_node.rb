require 'liquid'

module WofWof
  class LiquidTemplateNode < Node
    
    def initialize(node_repository, source_path, content, meta_info={})
      super(source_path, meta_info)
      self.template = true
      @liquid_template = Liquid::Template.parse(content)
      @node_repository = node_repository
    end

    def render(node, hash={})
      registers = { :current_node => node, :node_repository => @node_repository}
      @liquid_template.render(hash, :filters => [RouteToFilter], :registers => registers)
    end

    module RouteToFilter
      def route_to(input)
        regexp = Regexp.new(input)
        dest_node = @context.registers[:node_repository].find { |node| node.source_path =~ regexp }
        @context.registers[:current_node].dest_path.route_to(dest_node.dest_path)
      end
    end
  end
end
