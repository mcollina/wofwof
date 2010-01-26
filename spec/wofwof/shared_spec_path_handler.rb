
# This spec is based on the following instance variables:
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