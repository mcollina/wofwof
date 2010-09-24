require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Runtime do
  before(:each) do
    @context = mock "Context"
    @node_repository = mock "NodeRepository"
    Context.should_receive(:new).and_return(@context)
    @context.should_receive(:nodes).any_number_of_times.and_return(@node_repository) 
    @instance = Runtime.new
  end

  it "should respond to sources" do
    @instance.should respond_to(:sources)
  end

  it "should have a source method that returns an empty array" do
    @instance.sources.should == []
  end

  it "should respond to render" do
    @instance.should respond_to(:render)
  end

  it "should have a dest_path_handler accessor" do
    @instance.should respond_to(:dest_path_handler)
    @instance.should respond_to(:dest_path_handler=)
  end

  it "should have a nil dest_path_handler by default" do
    @instance.dest_path_handler.should be_nil
  end

  it "should correctly set the dest_path_handler" do
    dest_path_handler = mock "Dest PathHandler"
    @instance.dest_path_handler = dest_path_handler
    @instance.dest_path_handler.should == dest_path_handler
  end
  
  it "should respond to nodes" do
    @instance.should respond_to(:nodes)
  end

  it "should have a nodes method that returns a NodeRepository" do
    @instance.nodes.should == @node_repository 
  end

  it "should sort and call build_nodes to all sources when calling render" do
    first_source = mock "First Source"
    first_source.should_receive(:build_nodes).with(@context)
    second_source = mock "First Source"
    second_source.should_receive(:build_nodes).with(@context)

    first_source.should_receive(:<=>).with(second_source).any_number_of_times.and_return(-1)
    second_source.should_receive(:<=>).with(first_source).any_number_of_times.and_return(1)

    @instance.sources << first_source
    @instance.sources << second_source

    @node_repository.should_receive(:each)

    @instance.render
  end

  it "should correctly build a node" do
    io = mock "IO"

    base_path = mock "BasePath"
    
    rebased_dest_path = mock "RebasedDestPath"

    dest_path = mock "DestPath"
    dest_path.should_receive(:rebase).with(base_path).and_return(rebased_dest_path)

    node = mock "Node"
    node.should_receive(:buildable?).and_return(true)
    node.should_receive(:build).with(io)
    node.should_receive(:dest_path).and_return(dest_path)

    source = mock "First Source"
    source.should_receive(:build_nodes).with(@context)
    @instance.nodes.should_receive(:each).and_yield(node)

    path_handler = mock "PathHandler"
    path_handler.should_receive(:base_path).and_return(base_path)
    path_handler.should_receive(:open).with(rebased_dest_path, "w").and_yield(io)
    
    @instance.dest_path_handler = path_handler

    @instance.sources << source

    @instance.render
  end

  it "should correctly skip an unbuildable node" do

    node = mock "Node"
    node.should_receive(:buildable?).and_return(false)

    source = mock "First Source"
    source.should_receive(:build_nodes).with(@context)
    @instance.nodes.should_receive(:each).and_yield(node)

    path_handler = mock "PathHandler" # this mock should receive no messages

    @instance.dest_path_handler = path_handler

    @instance.sources << source

    @instance.render
  end
end

