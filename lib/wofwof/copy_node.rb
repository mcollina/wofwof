module WofWof
  class CopyNode < Node
    def initialize(source_path, dest_path, path_handler, meta_info={})
      super(source_path, meta_info)
      @path_handler = path_handler
      self.dest_path = dest_path
    end

    def build(write_io)
      @path_handler.open(source_path, "r") do |read_io|
        write_io << read_io.read
      end
      self
    end
  end
end
