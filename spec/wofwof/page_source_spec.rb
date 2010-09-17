require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), 'shared_spec_source'))

describe PageSource do

  it_should_behave_like AllSources
    
  before(:each) do
    @path_handler = mock "PathHandler"
    
    @instance = PageSource.new(@path_handler)
  end

  it "should correctly create two page nodes if the path handler extracts two paths" do
    first_path = mock "First.page"
    second_path = mock "Second.page"
    @path_handler.should_receive(:each).and_yield(first_path).and_yield(second_path)
    
    node_repository = mock "NodeRepository"
   
    first_node = mock "FirstNode"
    PageNode.should_receive(:new).with(node_repository, first_path, @path_handler).and_return(first_node)

    second_node = mock "SecondNode"
    PageNode.should_receive(:new).with(node_repository, second_path, @path_handler).and_return(second_node)

    node_repository.should_receive(:store).with(first_node)
    node_repository.should_receive(:store).with(second_node)
    
    @instance.build_nodes(node_repository)
  end
end


