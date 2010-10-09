
module WofWof
  class Runtime
    
    attr_reader :sources, :context
    attr_accessor :dest_path_handler
      
    def initialize
      @context = Context.new
      @sources = []
    end

    def render
      @sources.sort.each { |source| source.build_nodes(@context) }
      context.nodes.each do |node|
        next unless node.buildable?
        rebased_dest_path = node.dest_path.rebase(dest_path_handler.base_path)
        context.logger.info "rendering #{node.source_path.local_path} into #{node.dest_path.local_path}."
        dest_path_handler.open(rebased_dest_path, "w") do |io|
          node.build(io)
        end
      end
    end
  end
end
