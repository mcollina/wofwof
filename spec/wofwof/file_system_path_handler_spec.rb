require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), 'shared_spec_path_handler'))
require 'stringio'

describe FileSystemPathHandler do

  it_should_behave_like AllPathHandlers

  before(:each) do
    @base_path = Path.new("full_path", "", true) 
    @instance = FileSystemPathHandler.new(@base_path)

    @allElements = []
    @rightPattern = "right"
    @rightPatternElements = []
    @wrongPattern = "wrong"

    directories = ["right", "wrong"]
    directories.each do |dir|
      Dir.should_receive(:directory?).any_number_of_times.with(dir).and_return(true)
      @allElements << Path.new(@base_path, dir, true)
    end
    
    files = []
    directories.each do |dir_name|
      (1..6).each do |i|
        file_name = "#{dir_name}/#{i}"
        files << file_name
        Dir.should_receive(:directory?).any_number_of_times.with(file_name).and_return(false)
        @allElements << Path.new(@base_path, file_name)
      end
    end

    matcher = Dir.should_receive(:glob).with("**/*").any_number_of_times
    (files + directories).each { |e| matcher.and_yield(e) }
  end

  describe "with a readble path mocked" do

    it_should_behave_like ReadablePathHandlers

    before(:each) do
      @readablePath = mock "readable path"
      @readablePath.should_receive(:full_path).and_return("/the/full/path")
      @readablePathContent = "AAAAAAAAAAAAAA"
      io = StringIO.new(@readablePathContent)
      Kernel.should_receive(:open).with("/the/full/path", "r").and_yield(io)
    end
  end

  describe "with a writable path mocked" do

    it_should_behave_like WritablePathHandlers

    before(:each) do
      @writablePath = mock "writable path"
      @writablePath.should_receive(:full_path).twice.and_return("/the/full/path")
      writeIO = StringIO.new()
      Kernel.should_receive(:open).with("/the/full/path", "w").and_yield(writeIO).
        and_return do
        writeIO.rewind
        nil
      end
      Kernel.should_receive(:open).with("/the/full/path", "r").and_yield(writeIO)
    end
  end
end
