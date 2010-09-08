require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), 'shared_spec_path_handler'))
require 'stringio'

describe PathHandler do

  before(:each) do
    @base_path = mock "BasePath"
    @base_path.should_receive(:local_path).any_number_of_times.and_return("")
    @instance = PathHandler.new(@base_path)
  end

  it "should raise an exception if the open method is called" do
    lambda { 
      @instance.open(mock("Path"), "r") { |io| }
    }.should raise_error(NotImplementedError)
  end

  it "should raise an exception if the each method is called" do
    lambda { @instance.each }.should raise_error(NotImplementedError)
  end

  describe "mocking the each method" do

    it_should_behave_like AllPathHandlers

    before(:each) do
      @all_elements = []
      @right_pattern = "a_pattern"
      @right_pattern_elements = []
      @wrong_pattern = "wrong_pattern"

      (1..6).each do |l|
        path = mock "Path #{l}"
        @all_elements << path
      
        path.should_receive(:=~).with(@wrong_pattern).any_number_of_times.and_return(false)
        if l % 2 == 0
          path.should_receive(:=~).with(@right_pattern).any_number_of_times.and_return(false)
        else
          path.should_receive(:=~).with(@right_pattern).any_number_of_times.and_return(true)
          @right_pattern_elements << path
        end
      end

      matcher = @instance.should_receive(:each).any_number_of_times
      @all_elements.each { |e| matcher.and_yield(e) }
    end
  end

  describe "with a readble path configured" do

    it_should_behave_like ReadablePathHandlers

    before(:each) do
      @readable_path = mock "readable path"
      @readable_pathContent = "AAAAAAAAAAAAAA"
      io = StringIO.new(@readable_pathContent)
      @instance.should_receive(:open).with(@readable_path, "r").and_yield(io).
        and_return(@instance)
    end
  end

  describe "with a writable path configured" do

    it_should_behave_like WritablePathHandlers

    before(:each) do
      @writable_path = mock "writable path"
      writeIO = StringIO.new()
      @instance.should_receive(:open).with(@writable_path, "w").and_yield(writeIO).
        and_return do
        writeIO.rewind
        @instance
      end
      @instance.should_receive(:open).with(@writable_path, "r").and_yield(writeIO).
        and_return(@instance)
    end
  end
end
