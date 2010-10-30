module WofWof
  class LiquidTemplateSource < Source

    def build_nodes(context)
      path_handler.each do |path|
        path_handler.open(path, "r") do |io|
          context.nodes.store LiquidTemplateNode.new(context.nodes, path, io.read)
        end
      end
    end
  end
end
