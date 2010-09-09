require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), 'shared_spec_node'))
require 'stringio'

describe CopyNode do

  it_should_behave_like AllNodes

  before(:each) do
    @source_path = mock "SourcePath"
    @path_handler = mock "PathHandler"
    @instance = CopyNode.new(@source_path, @path_handler)
  end

  it "should have a dest_path equal to its source_path" do
    @instance.dest_path.should == @source_path
  end

  it "should have a constructor which accepts also a meta_info hash" do
    lambda { 
      @instance = CopyNode.new(@source_path, @path_handler, :hello => "world")
    }.should_not raise_error
    @instance.meta_info.should == { :hello => "world" }
  end

  it "should have a build method" do
    @instance.should respond_to(:build)
  end

  it "should be buildable" do
    @instance.should be_buildable
  end

  it "should correctly copy the node read from the input path_handler" do
    content = "the input string"
    input = StringIO.new(content)
    output = StringIO.new
    @path_handler.should_receive(:open).with(@source_path, "r").and_yield(input)
    @instance.build(output)
    output.string.should == content
  end
end
