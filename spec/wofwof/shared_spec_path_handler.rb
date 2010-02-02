
# This shared spec is based on the following instance variables:
#  * @instance: the path handler
#  * @allElements: all paths reachable through the path handler
#  * @rightPattern: a glob pattern
#  * @rightPatternElements: the elements returned by that glob pattern
#  * @wrongPattern: a glob pattern that returns no paths
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
    paths.size.should == @allElements.size
    paths.should include(*@allElements)
  end

  it "should have a glob method that acceps a pattern and search all paths matching with it" do
    paths = []
    @instance.glob(@rightPattern) { |e| paths << e }
    @rightPatternElements.size.should == paths.size
    @rightPatternElements.should include(*paths)
  end

  it "should have a glob method that returns an empty array if the specified pattern doesn't match" do
    paths = []
    @instance.glob(@wrongPattern) { |e| paths << e }
    paths.should == []
  end

  it "should have a glob method that navigates all specified paths if there is no pattern" do
    paths = []
    @instance.glob { |e| paths << e }
    paths.size.should == @allElements.size
    paths.should include(*@allElements)
  end

end

# This shared spec is based on the following instance variables:
#  * @instance: the path handler
#  * @readablePath: a path which is readable
#  * @readablePathContent: the content of the readablePath
share_as :ReadablePathHandlers do

  it "should read the readable path" do
    content = nil
    out = @instance.open(@readablePath, "r") do |io|
      content = io.read
    end

    content.should == @readablePathContent
    out.should == @instance
  end
end

# This shared spec is based on the following instance variables:
#  * @instance: the path handler
#  * @writablePath: a path which is readable
share_as :WritablePathHandlers do

  it "should read and write the writable path" do
    writablePathContent = "pua pua"
    out = @instance.open(@writablePath, "w") do |io|
      io << writablePathContent
    end
    
    out.should == @instance

    content = nil
    out = @instance.open(@writablePath, "r") do |io|
      content = io.read
    end
    content.should == writablePathContent

    out.should == @instance
  end
end