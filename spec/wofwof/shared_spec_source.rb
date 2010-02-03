
share_as :AllSources do

  it "should respond to build_nodes" do
    @instance.should respond_to(:build_nodes)
  end

  it "should have a build_nodes method that returns an array" do
    @instance.build_nodes.should respond_to(:to_ary)
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