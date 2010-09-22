require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), 'shared_spec_source'))

describe LiquidTemplateSource do

  it_should_behave_like AllSources
    
  before(:each) do
    @path_handler = mock "PathHandler"
    
    @instance = LiquidTemplateSource.new(@path_handler)
  end

  it "should correctly create two template nodes if the path handler extracts two paths" do
    first_path = mock "First.template"
    first_path_io = mock "first path io"
    first_path_content = mock "first path content"
    first_node = mock "FirstNode"
    second_path = mock "Second.template"
    second_path_io = mock "second path io"
    second_path_content = mock "second path content"
    second_node = mock "SecondNode"

    @path_handler.should_receive(:each).and_yield(first_path).and_yield(second_path)
    
    @path_handler.should_receive(:open).with(first_path, "r").and_yield(first_path_io)
    @path_handler.should_receive(:open).with(second_path, "r").and_yield(second_path_io)

    first_path_io.should_receive(:read).and_return(first_path_content)
    second_path_io.should_receive(:read).and_return(second_path_content)

    node_repository = mock "NodeRepository"
    node_repository.should_receive(:store).with(first_node)
    node_repository.should_receive(:store).with(second_node)

    LiquidTemplateNode.should_receive(:new).with(node_repository, first_path, first_path_content).and_return(first_node)
    LiquidTemplateNode.should_receive(:new).with(node_repository, second_path, second_path_content).and_return(second_node)

    @instance.build_nodes(node_repository)
  end
end


