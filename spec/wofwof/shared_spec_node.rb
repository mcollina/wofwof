require 'stringio'

share_as :AllNodes do

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

  it "should be able to store some information in the meta_info hash" do
    @instance.meta_info[:hello].should be_nil
    @instance.meta_info[:hello] = "world"
    @instance.meta_info[:hello].should == "world"
  end

  it "should respond to buildable?" do
    @instance.should respond_to(:buildable?)
  end

  it "should be buildable if it has got a dest path" do
    @instance.dest_path = mock "Path"
    @instance.should_receive(:template?).and_return(false)
    @instance.should be_buildable
  end

  it "should not be buildable if it hasn't got a dest path" do
    @instance.dest_path = nil
    @instance.should_not be_buildable
  end

  it "should respond to template?" do
    @instance.should respond_to(:template?)
  end

  it "should not be buildable if it is a template" do
    @instance.dest_path = mock "Path"
    @instance.should_receive(:template?).and_return(true)
    @instance.should_not be_buildable
  end
end

share_as :AllStandardNodes do
  it_should_behave_like AllNodes

  it "should respond to build" do
    @instance.should respond_to(:build)
  end

  it "should be buildable" do
    @instance.should be_buildable
  end
 
  it "should not be a template" do
    @instance.should_not be_template
  end
end

share_as :AllTemplateNodes do
  it_should_behave_like AllNodes

  it "should respond to render" do
    @instance.should respond_to(:render)
  end

  it "should not be buildable" do
    @instance.should_not be_buildable
  end

  it "should be a template" do
    @instance.should be_template
  end

  it "should render the content of the passed hash" do
    @instance.render(@node, :main => "hello world" ).should =~ /hello world/
  end
end
