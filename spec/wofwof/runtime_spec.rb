require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Runtime do
  before(:each) do
    @instance = Runtime.new
  end

  it "should respond to register" do
    @instance.should respond_to(:register)
  end

  it "should respond to sources" do
    @instance.should respond_to(:sources)
  end

  it "should respond to render" do
    @instance.should respond_to(:render)
  end
  
  it "should respond to nodes" do
    @instance.should respond_to(:nodes)
  end

  it "should have a nodes method that returns an empty NodeRepository" do
    @instance.nodes.should be_kind_of(NodeRepository)
    count = 0
    @instance.nodes.each { |n| count += 1 }
    count.should == 0
  end
end

