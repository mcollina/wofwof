
share_as :AllSources do

  it "should respond to build_nodes" do
    @instance.should respond_to(:build_nodes)
  end

  it "should return an empty array if an empty PathHandler is given" do
    path_handler = mock "PathHandler"
    path_handler.should_receive(:each).any_number_of_times
    path_handler.should_receive(:glob).any_number_of_times
    @instance.build_nodes(path_handler).should == []
  end

  it "should have 0-argument constructor" do
    klass = @instance.class
    lambda { klass.new }.should_not raise_error
  end
  
  it "should respond to prerequisites" do
    @instance.should respond_to(:prerequisites)
  end

  it "should have its prerequisites expressed with an array" do
    @instance.prerequisites.should respond_to(:to_ary)
  end
end