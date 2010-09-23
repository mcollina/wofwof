
module WofWof
  class Runtime
    
    attr_reader :nodes, :configuration, :sources
    attr_accessor :dest_path_handler
      
    def initialize
      @configuration = ConfigurationStore.new
      @nodes = NodeRepository.new(@configuration)
      @sources = []
    end

    def render
      @sources.sort.each { |source| source.build_nodes(@nodes) }
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
