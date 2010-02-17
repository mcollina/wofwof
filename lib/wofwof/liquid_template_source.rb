module WofWof
  class LiquidTemplateSource < Source

    def build_nodes(node_repository)
      path_handler.each do |path|
        path_handler.open(path, "r") do |io|
          node_repository.store LiquidTemplateNode.new(path, io.read)
        end
      end
    end
  end
end
