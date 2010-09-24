module WofWof
  class PageSource < Source

    def build_nodes(context)
      path_handler.each do |path|
        context.nodes.store PageNode.new(context, path, path_handler)
      end
    end
  end
end
