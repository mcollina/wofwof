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
  node
end

