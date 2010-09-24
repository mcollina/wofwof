require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Context do

  before(:each) do
    @configuration_store = mock "ConfigurationStore"
    ConfigurationStore.should_receive(:new).at_most(1).and_return(@configuration_store)
    @nodes = mock "NodeRepository"
    NodeRepository.should_receive(:new).at_most(1).and_return(@nodes)
    @instance = Context.new
  end

  it "should have a configuration attribute reader" do
    @instance.should respond_to(:configuration)
  end

  it "should have the configuration initialized at with an instance of ConfigurationStore" do
    @instance.configuration.should == @configuration_store
  end

  it "should have a nodes attribute reader" do
    @instance.should respond_to(:nodes)
  end

  it "should have the nodes initialized at with an instance of NodeRepository" do
    @instance.nodes.should == @nodes
  end
end
