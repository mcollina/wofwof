require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.join(File.dirname(__FILE__), 'shared_spec_node'))

describe LiquidTemplateNode do

  it_should_behave_like AllNodes

  before(:each) do
    @source_path = mock "SourcePath"
    @content = "Hello {{ name }}"
    @instance = LiquidTemplateNode.new(@source_path, @content)
  end

  it "should render corretly the passed content" do
    @instance.render("name" => "World").should == "Hello World"
  end
end

