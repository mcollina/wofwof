
# This shared spec is based on the following instance variables:
#  * @instance: the path handler
#  * @all_elements: all paths reachable through the path handler
#  * @right_pattern: a glob pattern
#  * @right_pattern_elements: the elements returned by that glob pattern
#  * @wrong_pattern: a glob pattern that returns no paths
share_as :AllPathHandlers do
  it "should respond to each" do
    @instance.should respond_to(:each)
  end

  it "should respond to glob" do
    @instance.should respond_to(:glob)
  end

  it "should respond to open" do
    @instance.should respond_to(:open)
  end

  it "should respond to base_path" do
    @instance.should respond_to(:base_path)
  end

  it "should have a not null base_path" do
    @instance.base_path.should_not be_nil
  end

  it "should have a base_path with an empty local_path" do
    @instance.base_path.local_path.should == ""
  end

  it "should have an each method that navigates all specified paths" do
    paths = []
    @instance.each { |e| paths << e }
    paths.size.should == @all_elements.size
    paths.should include(*@all_elements)
  end

  it "should have a glob method that acceps a pattern and search all paths matching with it" do
    paths = []
    @instance.glob(@right_pattern) { |e| paths << e }
    @right_pattern_elements.size.should == paths.size
    @right_pattern_elements.should include(*paths)
  end

  it "should have a glob method that returns an empty array if the specified pattern doesn't match" do
    paths = []
    @instance.glob(@wrong_pattern) { |e| paths << e }
    paths.should == []
  end

  it "should have a glob method that navigates all specified paths if there is no pattern" do
    paths = []
    @instance.glob { |e| paths << e }
    paths.size.should == @all_elements.size
    paths.should include(*@all_elements)
  end

end

# This shared spec is based on the following instance variables:
#  * @instance: the path handler
#  * @readable_path: a path which is readable
#  * @readable_pathContent: the content of the readable_path
share_as :ReadablePathHandlers do

  it "should read the readable path" do
    content = nil
    out = @instance.open(@readable_path, "r") do |io|
      content = io.read
    end

    content.should == @readable_pathContent
    out.should == @instance
  end
end

# This shared spec is based on the following instance variables:
#  * @instance: the path handler
#  * @writable_path: a path which is readable
share_as :WritablePathHandlers do

  it "should read and write the writable path" do
    writable_pathContent = "pua pua"
    out = @instance.open(@writable_path, "w") do |io|
      io << writable_pathContent
    end
    
    out.should == @instance

    content = nil
    out = @instance.open(@writable_path, "r") do |io|
      content = io.read
    end
    content.should == writable_pathContent

    out.should == @instance
  end
end
