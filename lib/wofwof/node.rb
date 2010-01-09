
module WofWof
  class Node

    attr_reader :source_path
    attr_accessor :dest_path

    def initialize(source_path)
      @source_path = source_path
    end
  end
end
