module WofWof
  class CopyNode < Node
    def initialize(context, source_path, path_handler, meta_info={})
      super(source_path, meta_info)
      @path_handler = path_handler
      self.dest_path = source_path
    end

    def build(write_io)
      @path_handler.open(source_path, "r") do |read_io|
        write_io << read_io.read
      end
      self
    end
  end
end
