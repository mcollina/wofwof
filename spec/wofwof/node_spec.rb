require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Node do

  before(:each) do
    @source_path = mock "SourcePath"
    @instance = Node.new(@source_path)
  end

  it "should respond to source_path" do
    @instance.should respond_to(:source_path)
  end

  it "should have as source path the one given to the constructor" do
    @instance.source_path.should == @source_path
  end

  it "should have a dest_path accessor" do
    @instance.should respond_to(:dest_path)
    @instance.should respond_to(:dest_path=)
  end

  it "should have a nil dest_path by default" do
    @instance.dest_path.should be_nil
  end

  it "should be able to set an object as a dest_path" do
    path = mock "DestPath"
    @instance.dest_path = path
    @instance.dest_path.should == path
  end

  it "should have a meta_info attribute" do
    @instance.should respond_to(:meta_info)
  end

  it "should have the meta informations stored in an hash" do
    @instance.meta_info.should be_kind_of(Hash)
  end

  it "should have a constructor which accepts also a meta_info hash" do
    @instance = Node.new(@source_path, :hello => "world")
    @instance.meta_info.should == { :hello => "world" }
  end
end
