
share_as :AllSources do

  it "should respond to path_handler" do
    @instance.should respond_to(:path_handler)
  end

  it "should respond to path_handler=" do
    @instance.should respond_to(:path_handler=)
  end

  it "should have a working path_handler accessor" do
    @instance.path_handler = nil
    @instance.path_handler.should be_nil

    path_handler = mock "PathHandler"
    @instance.path_handler = path_handler
    @instance.path_handler.should == path_handler
  end

  it "should respond to build_nodes" do
    @instance.should respond_to(:build_nodes)
  end
  
  it "should have 0-argument constructor" do
    lambda { @instance.class.new() }.should_not raise_error
  end

  it "should have 1-argument constructor which sets the path_handler" do
    path_handler = mock "PathHandler"
    lambda { @instance = @instance.class.new(path_handler) }.should_not raise_error
    @instance.path_handler.should == path_handler
  end
  
  it "should respond to prerequisites" do
    @instance.should respond_to(:prerequisites)
  end

  it "should have its prerequisites expressed with an array" do
    @instance.prerequisites.should respond_to(:to_ary)
  end

  it "should respond to <=>" do
    @instance.should respond_to(:<=>)
  end

  it "should include Comparable" do
    @instance.class.ancestors.should include(Comparable)
  end

  it "should respond to name" do
    @instance.should respond_to(:name)
  end
  
  it "should have a name which is a String" do
    @instance.name.should be_kind_of(String)
  end

  it "should have a name that doesn't include '::'" do
    @instance.name.should_not =~ /::/
  end
end