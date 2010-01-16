require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

def mock_node(key=nil)
  key = " " + key unless key.nil?
  path = mock "Path#{key}"
  node = mock "Node#{key}"
  node.should_receive(:source_path).at_least(1).and_return(path)
  node
end

describe NodeRepository do

  before(:each) do
    @instance = NodeRepository.new
  end

  it "should respond to all" do
    @instance.should respond_to(:all)
  end

  it "should respond to each" do
    @instance.should respond_to(:each)
  end

  it "should respond to []" do
    @instance.should respond_to(:[])
  end

  it "should respond to store" do
    @instance.should respond_to(:store)
  end

  it "should respond to unstore" do
    @instance.should respond_to(:unstore)
  end

  it "should have an all method that returns an empty array" do
    @instance.all.should == []
  end

  it "should be possible to store a node inside the repository" do
    @first_node = mock_node "first"
    lambda { @instance.store(@first_node) }.should_not raise_error
  end

  it "should include the Enumerable module" do
    @instance.class.ancestors.should include(Enumerable)
  end

  describe "with two nodes" do
    before(:each) do
      @first_node = mock_node "first"
      @second_node = mock_node "second"
      @instance.store(@first_node)
      @instance.store(@second_node)
    end

    it "should return all the nodes inside the all array" do
      @instance.all.should include(@first_node, @second_node)
    end

    it "should be able to fetch a node from the repository through []" do
      @instance[@first_node.source_path].should == @first_node
    end

    it "should be possible to store the same node twice" do
      lambda { @instance.store(@first_node) }.should_not raise_error
    end

    it "should be possible to unstore a node" do
      lambda { @instance.unstore(@first_node) }.should_not raise_error
      @instance[@first_node.source_path].should be_nil
      @instance.all.should == [@second_node]
    end

    it "should have an each method that iterates over all stored nodes" do
      ary = []
      @instance.each { |e| ary << e }
      ary.should include(@first_node)
      ary.should include(@second_node)
    end
  end
end

