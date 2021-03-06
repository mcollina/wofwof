module WofWof
  class AssetsSource < Source

    def build_nodes(context)
      path_handler.each do |path|
        context.nodes.store CopyNode.new(context, path, path_handler) 
      end
    end
  end
end
