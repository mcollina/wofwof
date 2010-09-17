module WofWof
  class PageSource < Source

    def build_nodes(node_repository)
      path_handler.each do |path|
        node_repository.store PageNode.new(node_repository, path, path_handler)
      end
    end
  end
end
