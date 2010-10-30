module WofWof
  class LiquidTemplateSource < Source

    def build_nodes(context)
      path_handler.each do |path|
        context.nodes.store LiquidTemplateNode.new(context, path, path_handler)
      end
    end
  end
end
