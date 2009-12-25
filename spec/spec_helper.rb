$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'wofwof'
require 'spec'
require 'spec/autorun'

include WofWof

Spec::Runner.configure do |config|
  
end
