require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.join(File.dirname(__FILE__), 'shared_spec_node'))

describe LiquidTemplateNode do

  def build(content)
    return LiquidTemplateNode.new(@node_repository, @source_path, content)
  end

  before(:each) do
    @node_repository = mock "NodeRepository"
    @source_path = mock "SourcePath"
    @node = mock "Node"
    @node_dest_path = mock "Node Path"
    @node.should_receive(:dest_path).any_number_of_times.and_return(@node_dest_path)
  end

  it "should render corretly the passed content" do
    instance = build("Hello {{ name }}")
    instance.render(@node, "name" => "World").should == "Hello World"
  end

  it "should render corretly the passed content even if the keyword is an Symbol" do
    instance = build("Hello {{ name }}")
    instance.render(@node, :name => "World").should == "Hello World"
  end

  it "should have a route_to filter" do
    wrong_node = mock "Wrong Node"
    wrong_path = mock "Wrong path"
    wrong_node.should_receive(:source_path).and_return(wrong_path)
    wrong_path.should_receive(:=~).with(/a_node/).and_return false

    right_node = mock "Right Node"
    right_source_path = mock "Right source path"
    right_node.should_receive(:source_path).and_return(right_source_path)
    right_source_path.should_receive(:=~).with(/a_node/).and_return true
    right_dest_path = mock "Right dest path"
    right_node.should_receive(:dest_path).and_return(right_dest_path)

    @node_dest_path.should_receive(:route_to).with(right_dest_path).and_return("path/to/heaven")

    @node_repository.should_receive(:find).and_yield(wrong_node).and_yield(right_node).and_return(right_node)
    instance = build("{{ 'a_node' | route_to }}")
    instance.render(@node).should == "path/to/heaven"
  end

  it "should have a route_to tag" do
    wrong_node = mock "Wrong Node"
    wrong_path = mock "Wrong path"
    wrong_node.should_receive(:source_path).and_return(wrong_path)
    wrong_path.should_receive(:=~).with(/a_node/).and_return false

    right_node = mock "Right Node"
    right_source_path = mock "Right source path"
    right_node.should_receive(:source_path).and_return(right_source_path)
    right_source_path.should_receive(:=~).with(/a_node/).and_return true
    right_dest_path = mock "Right dest path"
    right_node.should_receive(:dest_path).and_return(right_dest_path)

    @node_dest_path.should_receive(:route_to).with(right_dest_path).and_return("path/to/heaven")

    @node_repository.should_receive(:find).and_yield(wrong_node).and_yield(right_node).and_return(right_node)
    instance = build("{% route_to a_node %}")
    instance.render(@node).should == "path/to/heaven"
  end

  it "should have a route_to tag that throw exception if the dest node wasn't found" do
    wrong_node = mock "Wrong Node"
    wrong_path = mock "Wrong path"
    wrong_node.should_receive(:source_path).and_return(wrong_path)
    wrong_path.should_receive(:=~).with(/a_node/).and_return false

    @node_repository.should_receive(:find).and_yield(wrong_node).and_return(nil)
    
    instance = build("{% route_to a_node %}")
    lambda { instance.render(@node) }.should raise_error LiquidTemplateNode::NoRouteToNodeError
  end

  it "should have a link_to tag" do
    wrong_node = mock "Wrong Node"
    wrong_path = mock "Wrong path"
    wrong_node.should_receive(:source_path).and_return(wrong_path)
    wrong_path.should_receive(:=~).with(/a\.node/).and_return false

    right_node = mock "Right Node"
    right_source_path = mock "Right source path"
    right_node.should_receive(:source_path).and_return(right_source_path)
    right_source_path.should_receive(:=~).with(/a\.node/).and_return true
    right_dest_path = mock "Right dest path"
    right_node.should_receive(:dest_path).and_return(right_dest_path)

    @node_dest_path.should_receive(:route_to).with(right_dest_path).and_return("path/to/heaven")

    @node_repository.should_receive(:find).and_yield(wrong_node).and_yield(right_node).and_return(right_node)
    instance = build("{% link_to a.node, 'Hello World' %}")
    instance.render(@node).should == "<a href=\"path/to/heaven\">Hello World</a>"
  end
  
  it "should have a link_to tag which raise an exception if the wrong syntax is used" do
    lambda { build("{% link_to a.node, 'Hello World', third parameter %}") }.should raise_error
  end

  it "should have a link_to tag that emits a link even if it links to same file." do
    wrong_node = mock "Wrong Node"
    wrong_path = mock "Wrong path"
    wrong_node.should_receive(:source_path).and_return(wrong_path)
    wrong_path.should_receive(:=~).with(/a\.node/).and_return false

    node_source_path = mock "node source path"
    @node.should_receive(:source_path).and_return(node_source_path)
    node_source_path.should_receive(:=~).with(/a\.node/).and_return true

    @node_dest_path.should_receive(:route_to).with(@node_dest_path).and_return(nil)
    @node_dest_path.should_receive(:local_path).and_return("path/to/heaven")

    @node_repository.should_receive(:find).and_yield(wrong_node).and_yield(@node).and_return(@node)
    instance = build("{% link_to a.node, 'Hello World' %}")
    instance.render(@node).should == "<a href=\"path/to/heaven\">Hello World</a>"
  end

  it "should have a link_to tag that throw exception if the dest node wasn't found" do
    wrong_node = mock "Wrong Node"
    wrong_path = mock "Wrong path"
    wrong_node.should_receive(:source_path).and_return(wrong_path)
    wrong_path.should_receive(:=~).with(/a_node/).and_return false

    @node_repository.should_receive(:find).and_yield(wrong_node).and_return(nil)

    instance = build("{% link_to a_node, 'Hello World' %}")
    lambda { instance.render(@node) }.should raise_error LiquidTemplateNode::NoRouteToNodeError
  end

  describe "as a generic node" do

    it_should_behave_like AllNodes
    it_should_behave_like AllTemplateNodes

    before(:each) do
      @instance = build("Hello {{ main }}")
    end
  end
end

