require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), 'shared_spec_path_handler'))

describe PathHandler, "mocking the each method" do

  it_should_behave_like AllPathHandlers

  before(:each) do
    @instance = PathHandler.new
    @allElements = []
    @rightPattern = "a_pattern"
    @rightPatternElements = []
    @wrongPattern = "wrong_pattern"

    (1..6).each do |l|
      path = mock "Path #{l}"
      @allElements << path
      
      path.should_receive(:=~).with(@wrongPattern).any_number_of_times.and_return(false)
      if l % 2 == 0
        path.should_receive(:=~).with(@rightPattern).any_number_of_times.and_return(false)
      else
        path.should_receive(:=~).with(@rightPattern).any_number_of_times.and_return(true)
        @rightPatternElements << path
      end
    end

    matcher = @instance.should_receive(:each).any_number_of_times
    @allElements.each { |e| matcher.and_yield(e) }
  end

  it "should raise an exception if the open method is called" do
    lambda { 
      @instance.open(mock("Path"), "r") { |io| }
    }.should raise_error(NotImplementedError)
  end
end

describe PathHandler, "without mocking the each method" do

  before(:each) do
    @instance = PathHandler.new
  end

  it "should raise an exception if the each method is called" do
    lambda { @instance.each }.should raise_error(NotImplementedError)
  end
end