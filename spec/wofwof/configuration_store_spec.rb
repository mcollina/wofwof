require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe ConfigurationStore do
  
  before(:each) do
    @node_repository = mock "NodeRepository"
    @instance = ConfigurationStore.new(@node_repository)
  end

  it "should have a node_repository attribute reader" do
    @instance.should respond_to(:node_repository)
  end

  it "should have it node_repository initialized to the value passed to the constructor" do
    @instance.node_repository.should == @node_repository
  end
  
  it "should have a default_template accessor" do
    @instance.should respond_to(:default_template)
    @instance.should respond_to(:default_template=)
  end

  it "should raise a RuntimeError if there is no default_template" do
    @node_repository.should_receive(:select).and_return([])
    lambda { @instance.default_template }.should raise_error(RuntimeError) 
  end

  it "should search for a single template if there is no default template" do
    @single_template = mock_node "first"
    @node_repository.should_receive(:select).and_yield(@single_template).and_return([@single_template])
    @single_template.should_receive(:template?).and_return(true)
    @instance.default_template.should == @single_template
  end

  it "should search for a single template and raise RuntimeError if there is more than once." do
    @first_template = mock "first"
    @second_template = mock "second"
    @node_repository.should_receive(:select).and_yield(@first_template).and_yield(@second_template).
      and_return([@first_template, @second_template])
    @first_template.should_receive(:template?).and_return(true)
    @second_template.should_receive(:template?).and_return(true)
    lambda { @instance.default_template }.should raise_error(RuntimeError) 
  end
  
  it "should auto store the default template" do
    node = mock_node "first"
    @node_repository.should_receive(:store).with(node)
    @instance.default_template = node
  end
end
