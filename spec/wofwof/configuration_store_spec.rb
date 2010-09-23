require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe ConfigurationStore do
  
  before(:each) do
    @instance = ConfigurationStore.new
  end

  it "should have a default_template accessor" do
    @instance.should respond_to(:default_template)
    @instance.should respond_to(:default_template=)
  end

  it "should be able to contain elements that weren't specified" do
    lambda { 
      @instance.hello = :world
      @instance.hello.should == :world
    }.should_not raise_error
  end

  it "should raise exception if we call read methods with arguments" do
    lambda {
      @instance.hello :world
    }.should raise_error
  end
  
  it "should be able to contain boolean elements that weren't specified" do
    lambda { 
      @instance.hello = true 
      @instance.should be_hello
    }.should_not raise_error
  end

  it "should have a respond_to method that returns true after a value has been set" do
    @instance.should_not respond_to(:quack)
    @instance.should_not respond_to(:quack=)
    @instance.should_not respond_to(:quack?)
    @instance.quack = :quack
    @instance.should respond_to(:quack)
    @instance.should respond_to(:quack=)
    @instance.should respond_to(:quack?)
  end
end
