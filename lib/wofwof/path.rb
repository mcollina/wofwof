
module WofWof
  class Path

    attr_reader :base_path, :local_path

    def initialize(base_path, local_path, directory=false)
      raise ArgumentError.new("Missing base_path") if base_path.nil?
      raise ArgumentError.new("Missing local_path") if local_path.nil?

      if base_path.respond_to? :base_path and base_path.respond_to? :local_path
        local_path = File.join(base_path.local_path, local_path)
        base_path = base_path.base_path
      end

      @base_path = base_path.gsub(/\/$/, '')
      @local_path = local_path.gsub(/^\//, '').gsub(/\/$/, '')
      @directory = directory
    end

    def directory?
      @directory
    end

    def full_path
      File.join(@base_path, @local_path)
    end

    def eql? other
      return false unless other.respond_to? :local_path
      @local_path == other.local_path
    end

    alias :== :eql?

    def match regexp
      @local_path.match regexp
    end

    def hash
      @local_path.hash
    end

    def rebase(base_path)
      Path.new(base_path, @local_path)
    end

    def child_of?(parent)
      @local_path.length > parent.local_path.length and @local_path.start_with? parent.local_path
    end

    def parent_of?(children)
      children.child_of?(self)
    end

    def <=>(other)
      return -1 unless other.respond_to?(:local_path)
      self.local_path <=> other.local_path
    end
   
    def route_to(other)
      self_local_path_splitted = @local_path.split("/")
      other_local_path_splitted = other.local_path.split("/")

      common = []

      self_local_path_splitted.each_with_index do |e, i|
        #puts "self_local_path_splitted: #{e}"
        #puts "other_local_path_splitted: #{other_local_path_splitted[i]}" if i < other_local_path_splitted.size
        if i < other_local_path_splitted.size and other_local_path_splitted[i] == e
          common << e
        else
          break
        end
      end

      self_local_path_splitted -= common
      other_local_path_splitted -= common

      dest = []

      go_back = self_local_path_splitted.size
      go_back -= 1 unless go_back == 0

      go_back.times { |i| dest << ".." }
      
      other_local_path_splitted.each { |e| dest << e }

      dest.join("/")
    end
  end
end
