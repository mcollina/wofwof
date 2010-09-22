module WofWof
  class FileSystemPathHandler < PathHandler

    def initialize(base_path)
      super(base_path)
	end

    def each(&block)
      Dir.glob("#{base_path.full_path}/**/*") do |current|
	    path = Path.new(base_path, current.gsub(/^#{base_path.full_path}/, ""), 
                        File.directory?(current))
        block.call(path)
	  end
      self
    end

    def open(path, mode, &block)
      Kernel.open(path.full_path, mode, &block)
      self
    end
  end
end
