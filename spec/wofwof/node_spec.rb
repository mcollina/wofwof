require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), 'shared_spec_node'))

describe Node do

  it_should_behave_like AllNodes

  before(:each) do
    @source_path = mock "SourcePath"
    @instance = Node.new(@source_path)
  end

  it "should have a constructor which accepts also a meta_info hash" do
    @instance = Node.new(@source_path, :hello => "world")
    @instance.meta_info.should == { :hello => "world" }
  end

  it "should raise an error if its build method is called" do
    lambda { @instance.build }.should raise_error()
  end
end
