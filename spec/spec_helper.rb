$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'wofwof'
require 'rubygems'
require 'spec'
require 'spec/autorun'

include WofWof

Spec::Runner.configure do |config|
  
end

def mock_node(key=nil)
  key = " " + key unless key.nil?
  path = mock "Path#{key}"
  node = mock "Node#{key}"
  node.should_receive(:source_path).at_least(1).and_return(path)
  path.should_receive(:local_path).any_number_of_times.and_return("a/local/path")
  node
end

def mock_context
  logger = mock "Logger"
  logger.should_receive(:info).any_number_of_times
  logger.should_receive(:warn).any_number_of_times
  logger.should_receive(:error).any_number_of_times
  context = mock "Context"
  context.should_receive(:logger).any_number_of_times.and_return(logger)
  context
end

