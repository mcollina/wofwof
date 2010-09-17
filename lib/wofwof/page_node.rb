
module WofWof
  class PageNode < Node

    attr_reader :content

    def initialize(node_repository, source_path, path_handler)
      super(source_path)

      self.dest_path = source_path
      
      @node_repository = node_repository 
      @content = {}

      path_handler.open(source_path, "r") do |io|
        
        content = io.read

        split = content.split(/^---/)
       
        if split.size == 1
          @content[:main] = content
        else
          meta = YAML.load(split[0])
          if meta.respond_to? :each_pair
            # it's an hash, so we can inject its content in the meta_info hash
            meta.each_pair { |key, value| meta_info[key.to_sym] = value }
            split.shift
          end
          
          split.each do |section|
            section_split = section.split("\n")
            section_content = section_split[1..-1].join("\n") + "\n"
            
            if section_split[0].strip == ""
              section_name = :main
            elsif section_content.strip == ""
              section_name = :main
              section_content = split[0]
            else
              section_name = section_split[0].strip.to_sym
            end
            
            @content[section_name] = section_content
          end
        end 
      end

    end

    def build(io)
      io << template.render(self, meta_info.dup.merge!(content))
    end

    private
    def template
      if meta_info[:template].nil?
        @node_repository.default_template
      else
        @node_repository.find_by_path!(meta_info[:template])
      end
    end
  end
end
