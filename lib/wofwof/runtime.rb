
module WofWof
  class Runtime
    
    attr_reader :nodes
    attr_reader :sources
    attr_accessor :dest_path_handler
      
    def initialize
      @nodes = NodeRepository.new
      @sources = []
    end

    def render
      nodes = @sources.sort.inject([]) { |ary, source| ary.concat(source.build_nodes) }
      nodes.each do |node|
        next unless node.buildable?
        rebased_dest_path = node.dest_path.rebase(dest_path_handler.base_path)
        dest_path_handler.open(rebased_dest_path, "w") do |io|
          node.build(io)
        end
      end
    end
  end
end
