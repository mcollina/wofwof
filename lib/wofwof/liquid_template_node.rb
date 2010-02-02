require 'liquid'

module WofWof
  class LiquidTemplateNode < Node
    def initialize(source_path, content, meta_info={})
      super(source_path, meta_info)
      self.template = true
      @liquid_template = Liquid::Template.parse(content)
    end

    def render(hash)
      @liquid_template.render(hash)
    end
  end
end
