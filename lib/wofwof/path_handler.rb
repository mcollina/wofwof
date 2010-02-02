module WofWof
  class PathHandler

    attr_reader :base_path

    def initialize(base_path)
      @base_path = base_path
    end

    def glob(pattern = nil)
      each do |path|
        yield path if pattern.nil? or path =~ pattern
      end
    end

    def each(&block)
      raise NotImplementedError.new
    end

    def open(path, mode, &block)
      raise NotImplementedError.new
    end
  end
end
