require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), 'shared_spec_source'))

describe Source do

  before(:each) do
    @instance = Source.new
  end

  it "should raise an error when calling build_nodes" do
    lambda { @instance.build_nodes }.should raise_error(NotImplementedError)
  end

  describe "with the build_nodes mocked" do
    it_should_behave_like AllSources

    before(:each) do
      @instance.should_receive(:build_nodes).at_most(1).and_return([])
    end
  end

  describe "as a Comparable class" do

    before(:each) do
      @first = Source.new
      @first.should_receive(:name).any_number_of_times.and_return("First")

      @second = Source.new
      @second.should_receive(:name).any_number_of_times.and_return("First2")

      @third = Source.new
      @third.should_receive(:name).any_number_of_times.and_return("Third")
    end

    it "should be sortable based on the lexical order" do
      [@third, @first, @second].sort.should == [@first, @second, @third]
    end

    it "should be sortable based on the prerequisites" do
      @third.should_receive(:prerequisites).any_number_of_times.and_return([])
      @second.should_receive(:prerequisites).any_number_of_times.and_return(["Third"])
      @first.should_receive(:prerequisites).any_number_of_times.and_return(["First2"])
      [@first, @second, @third].sort.should == [@third,@second, @first]
    end

    it "should be sortable based on both the prerequisites and the lexicographic order" do
      @third.should_receive(:prerequisites).any_number_of_times.and_return([])
      @second.should_receive(:prerequisites).any_number_of_times.and_return(["Third"])
      @first.should_receive(:prerequisites).any_number_of_times.and_return(["Third"])
      [@third, @first, @second].sort.should == [@third,@first, @second]
    end

    it "should correctly order the sources based on the lexicographic order" do
      @first.should < @second
      @second.should > @first
    end

    it "should correctly order the sources based on thre prerequisites" do
      @first.should_receive(:prerequisites).any_number_of_times.and_return(["First2"])
      @first.should > @second
      @second.should < @first
    end

    it "should correctly match equals" do
      @first.should_not == @second
      @first.should == @first
    end

    it "should correctly order sources with the same name based on their object id" do
      first_clone = Source.new
      first_clone.should_receive(:name).any_number_of_times.and_return("First")
      @first.should_not == first_clone
      (@first <=> first_clone).should == (@first.object_id <=> first_clone.object_id)
    end
  end
end


