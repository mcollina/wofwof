require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), 'shared_spec_source'))

describe Source do

  before(:each) do
    @instance = Source.new
  end

  it "should raise an error when calling build_nodes" do
    lambda { @instance.build_nodes(mock "PathHandler") }.should raise_error
  end

  describe "with the build_nodes mocked" do
    it_should_behave_like AllSources

    before(:each) do
      @instance.should_receive(:build_nodes).at_most(1).and_return([])
    end
  end
end

