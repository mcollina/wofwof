require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), 'shared_spec_source'))

describe AssetsSource do

  it_should_behave_like AllSources
    
  before(:each) do
    @path_handler = mock "PathHandler"
    
    @instance = AssetsSource.new(@path_handler)
  end

  it "should correctly create two template nodes if the path handler extracts two paths" do
    context = mock "Context"

    first_path = mock "First.template"
    first_node = mock "FirstNode"
    second_path = mock "Second.template"
    second_node = mock "SecondNode"

    @path_handler.should_receive(:each).and_yield(first_path).and_yield(second_path)

    CopyNode.should_receive(:new).with(context, first_path, @path_handler).and_return(first_node)
    CopyNode.should_receive(:new).with(context, second_path, @path_handler).and_return(second_node)

    node_repository = mock "NodeRepository"
    node_repository.should_receive(:store).with(first_node)
    node_repository.should_receive(:store).with(second_node)

    context.should_receive(:nodes).any_number_of_times.and_return(node_repository)

    @instance.build_nodes(context)
  end
end


