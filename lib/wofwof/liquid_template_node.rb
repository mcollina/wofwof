require 'liquid'

module WofWof
  class LiquidTemplateNode < Node
    
    def initialize(node_repository, source_path, content, meta_info={})
      super(source_path, meta_info)
      self.template = true
      @liquid_template = Liquid::Template.parse(content)
      @node_repository = node_repository
    end

    def render(node, hash={})
      new_hash = {}
      hash.each_pair { |k,v| new_hash[k.to_s] = v }

      registers = { :current_node => node, :node_repository => @node_repository}
      result = @liquid_template.render(new_hash, :registers => registers)
      @liquid_template.errors.each { |error| raise error }
      result
    end

    def self.route_to(context, input)
      regexp = Regexp.new(input.gsub('.', "\\."))
      dest_node = context.registers[:node_repository].find { |node| node.source_path =~ regexp }
      raise NoRouteToNodeError.new(input) if dest_node.nil?
      context.registers[:current_node].dest_path.route_to(dest_node.dest_path)
    end

    module WofWofFilters
      def route_to(input)
        LiquidTemplateNode.route_to(@context, input)
      end
    end
    Liquid::Template.register_filter(WofWofFilters)

    class RouteTo < Liquid::Tag

      def initialize(tag_name, regexp, tokens)
        super
        @regexp = regexp.strip
      end

      def render(context)
        LiquidTemplateNode.route_to(context, @regexp)
      end
    end
    Liquid::Template.register_tag("route_to", RouteTo)

    class LinkTo < Liquid::Tag
      SyntaxMulti = /^([a-zA-Z_0-9\.]+)[, ]*'(.*)'$/

      def initialize(tag_name, markup, tokens)
        if markup.strip! =~ SyntaxMulti
          @regexp = $1.strip
          @title = $2
        else
          raise SyntaxError.new("Syntax Error in 'link_to' - Valid syntax: link_to [node], [title]")
        end

        super
      end

      def render(context)
        route = LiquidTemplateNode.route_to(context, @regexp)
        route = context.registers[:current_node].dest_path.local_path if route.nil?
        "<a href=\"#{route}\">#{@title}</a>"
      end
    end
    Liquid::Template.register_tag("link_to", LinkTo)

    class NoRouteToNodeError < RuntimeError 
      def initialize(pattern)
        super("No route to node: #{pattern}")
      end
    end
  end
end
