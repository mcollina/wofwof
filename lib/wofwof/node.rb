
module WofWof
  class Node

    attr_reader :source_path, :meta_info
    attr_accessor :dest_path

    def initialize(source_path, meta_info={})
      @source_path = source_path
      @meta_info = meta_info
    end
  end
end
