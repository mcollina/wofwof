module WofWof
  module GenericSource   
    def self.build(node_class)
      source_class = Class.new(GenericInternalSource)
      source_class.node_class = node_class
      source_class
    end
    
    class GenericInternalSource < Source

      class << self; attr_accessor :node_class; end

      def initialize(path_handler=nil)
        super path_handler
      end

      def build_nodes(context)
        path_handler.each do |path|
          context.nodes.store self.class.node_class.new(context, path, path_handler)
        end
      end
    end
  end
end
