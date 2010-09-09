module WofWof
  class AssetsSource < Source

    def build_nodes(node_repository)
      path_handler.each do |path|
        node_repository.store CopyNode.new(path, path_handler) 
      end
    end
  end
end
