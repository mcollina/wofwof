require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Context do

  before(:each) do
    @configuration_store = mock "ConfigurationStore"
    ConfigurationStore.should_receive(:new).at_most(1).and_return(@configuration_store)
    @nodes = mock "NodeRepository"
    NodeRepository.should_receive(:new).at_most(1).and_return(@nodes)
    @instance = Context.new
  end

  it "should have a configuration attribute reader" do
    @instance.should respond_to(:configuration)
  end

  it "should have the configuration initialized at with an instance of ConfigurationStore" do
    @instance.configuration.should == @configuration_store
  end

  it "should have a nodes attribute reader" do
    @instance.should respond_to(:nodes)
  end

  it "should have the nodes initialized at with an instance of NodeRepository" do
    @instance.nodes.should == @nodes
  end

  it "should respond to logger" do
    @instance.should respond_to(:logger)
  end

  it "should return a valid instance of logger" do
    io = mock "IO"
    level = mock "level"
    @configuration_store.should_receive(:log_io).and_return(io)
    @configuration_store.should_receive(:log_level).and_return(level)
    logger = mock "logger"
    logger.should_receive(:level=).with(level)
    Logger.should_receive(:new).with(io).and_return(logger)
    @instance.logger.should == logger
  end

  it "should cache the generated logger" do
    io = mock "IO"
    level = mock "level"
    @configuration_store.should_receive(:log_io).and_return(io)
    @configuration_store.should_receive(:log_level).and_return(level)
    logger = mock "logger"
    logger.should_receive(:level=).with(level)
    Logger.should_receive(:new).with(io).and_return(logger)
    @instance.logger.should === logger
    @instance.logger.should === logger
  end

  it "should create a logger without a level, setting it to Logger::FATAL" do
    io = mock "IO"
    @configuration_store.should_receive(:log_io).and_return(io)
    @configuration_store.should_receive(:log_level).and_return(nil)
    logger = mock "logger"
    logger.should_receive(:level=).with(Logger::FATAL)
    Logger.should_receive(:new).with(io).and_return(logger)
    @instance.logger.should === logger
  end

  it "should create a logger without an io, setting it to STDOUT" do
    level = mock "level"
    @configuration_store.should_receive(:loglevel_io).and_return(nil)
    @configuration_store.should_receive(:log_level).and_return(level)
    logger = mock "logger"
    logger.should_receive(:level=).with(level)
    Logger.should_receive(:new).with(STDOUT).and_return(logger)
    @instance.logger.should === logger
  end
end
