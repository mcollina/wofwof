require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Path, "with basic parameters" do

  before :each do
    @base_path = "base"
    @local_path = "local"
    @instance = Path.new(@base_path, @local_path)
  end

  it "should respond to base_path" do
    @instance.should respond_to(:base_path)
  end

  it "should respond to local_path" do
    @instance.should respond_to(:local_path)
  end

  it "should respond to full_path" do
    @instance.should respond_to(:full_path)
  end

  it "should have the specified base path" do
    @instance.base_path.should == @base_path
  end

  it "should have the specified local path" do
    @instance.local_path.should == @local_path
  end

  it "should have a full path constructed with the specified paths" do
    @instance.full_path.should == File.join(@base_path, @local_path)
  end

  it "shouldn't have a nil base_path" do
    lambda {
      Path.new(nil, @local_path)
    }.should raise_error(ArgumentError)
  end

  it "shouldn't have a nil local_path" do
    lambda {
      Path.new(@base_path, nil)
    }.should raise_error(ArgumentError)
  end

  it "should have a == method that compares only the local part (true case)" do
    other = Path.new("another", @local_path)
    @instance.should == other
    other.should == @instance
  end

  it "should have a == method that compares only the local part (identity case)" do
    @instance.should == @instance
  end

  it "should have a == method that compares only the local part (false case)" do
    other = Path.new("another", "path")
    @instance.should_not == other
    other.should_not == @instance
  end

  it "should have a eql? method that compares only the local part (true case)" do
    other = Path.new("another", @local_path)
    @instance.should be_eql(other)
    other.should be_eql(@instance)
  end

  it "should have a eql? method that compares only the local part (identity case)" do
    @instance.should be_eql(@instance)
  end

  it "should have a eql? method that compares only the local part (false case)" do
    other = Path.new("another", "path")
    @instance.should_not be_eql(other)
    other.should_not be_eql(@instance)
  end

  it "should have an hash method that generates the hash of the local part" do
    @instance.hash.should == @local_path.hash
  end

  it "should have a rebase method" do
    @instance.should respond_to(:rebase)
  end

  it "should be rebasable to a differente base_path" do
    another_base_path = "another/base/path"
    rebased = @instance.rebase(another_base_path)
    rebased.base_path.should == another_base_path
    rebased.local_path.should == @local_path
  end

  it "should have a directory? attribute reader" do
    @instance.should respond_to(:directory?)
  end

  it "should not be a directory by default" do
    @instance.should_not be_directory
  end

  it "should accept a third optional parameter as a directory" do
    lambda {
      other = Path.new(@base_path, @local_path, true)
      other.should be_directory
    }.should_not raise_error
  end

  it "should be equal to an identical path but with a local part starting with '/'" do
    other = Path.new(@base_path, "/" + @local_path)
    other.should == @instance
    @instance.should == other

    @instance.should be_eql(other)
    other.should be_eql(@instance)
  end

  it "should discard the starting '/' in the local path" do
    other = Path.new(@base_path, "/" + @local_path)
    other.local_path.should == @local_path
  end

  it "should discard the trailing '/' in the local path" do
    other = Path.new(@base_path, @local_path + "/")
    other.local_path.should == @local_path
  end

  it "should discard the trailing '/' in the base path" do
    other = Path.new(@base_path + "/", @local_path)
    other.base_path.should == @base_path
  end

  it "should respond to child_of?" do
    @instance.should respond_to(:child_of?)
  end

  it "should respond to parent_of?" do
    @instance.should respond_to(:parent_of?)
  end

  it "should not be the child of itself" do
    @instance.should_not be_child_of(@instance)
  end

  it "should not be the parent of itself" do
    @instance.should_not be_parent_of(@instance)
  end

  it "should be the parent of a path containing its local path" do
    other = Path.new(@base_path, "local/booh")
    @instance.should be_parent_of(other)
    other.should be_child_of(@instance)
  end

  it "should respond to match" do
    @instance.should respond_to(:match)
  end

  it "should match its local part against the regexp given to =~" do
    @instance.should_not match(/gh/)
    @instance.should match(/loc/)
  end
  
  it "should respond to =~" do
    @instance.should respond_to(:match)
  end

  it "should match its local part against the regexp given to =~" do
    @instance.should_not =~ /gh/
    @instance.should =~ /loc/
  end

  it "should respond to" do
    @instance.should respond_to(:<=>)
  end

  it "should be sortable" do
    first = Path.new("base", "a")
    second = Path.new("another/base", "a/b")
    third = Path.new("base", "a/c")
    fourth = Path.new("base", "d")

    [fourth, second, first, third].sort.should == [first, second, third, fourth]
  end

  it "should have a route_to method" do
    @instance.should respond_to(:route_to)
  end

  it "should generate the correct route to a node in the same directory" do
    other = Path.new(@base_path, "other")
    @instance.route_to(other).should == other.local_path
  end

  it "should generate the correct route to a node in a deeper directory" do
    other = Path.new(@base_path, "directory/other")
    @instance.route_to(other).should == other.local_path
  end

  it "should generate the correct route to a node in a shallower directory" do
    other = Path.new(@base_path, "directory/other")
    other.route_to(@instance).should == "../#{@instance.local_path}"
  end

  it "should generate the correct route to a node in the same deep directory" do
    first = Path.new(@base_path, "a/first")
    second = Path.new(@base_path, "a/second")
    first.route_to(second).should == "second"
  end

  it "should generate the correct route to a node in a directory with the same level of deepness" do
    first = Path.new(@base_path, "a/first")
    second = Path.new(@base_path, "b/second")
    first.route_to(second).should == "../#{second.local_path}"
  end

  it "should generate the correct route to a node with a different base path" do
    other = Path.new("another_base_path", "other")
    @instance.route_to(other).should == other.local_path
  end

  it "should generate nil if asked to route to itself" do
    @instance.route_to(@instance).should be_nil
  end

  it "should have an ext attribute" do
    @instance.should respond_to(:ext)
  end

  it "should have an empty ext if the path has no extension" do
    @instance.ext.should == ""
  end
  
  it "should have an change_ext attribute" do
    @instance.should respond_to(:change_ext)
  end
  
  it "should have a change_ext method that emits a new path" do
    @local_path = "local.ext"
    @instance = Path.new(@base_path, @local_path)
    new_path = @instance.change_ext("pua")
    new_path.should_not == @instance
    new_path.ext.should == "pua"
    new_path.local_path.should == "local.pua"
    new_path.base_path.should == @base_path
  end

  it "shoud have a change_ext method that adds the ext if it's missing" do
    @local_path = "local"
    @instance = Path.new(@base_path, @local_path)
    new_path = @instance.change_ext("pua")
    new_path.should_not == @instance
    new_path.ext.should == "pua"
    new_path.local_path.should == "local.pua"
    new_path.base_path.should == @base_path
  end

  it "should have a change_ext method that emits a new path and can work with directories" do
    @local_path = "dir/local.ext"
    @instance = Path.new(@base_path, @local_path)
    new_path = @instance.change_ext("pua")
    new_path.should_not == @instance
    new_path.ext.should == "pua"
    new_path.local_path.should == "dir/local.pua"
    new_path.base_path.should == @base_path
  end
end

describe Path, "with a Path as constructor argument" do
  before(:each) do
    @base_path = "base"
    @parent_local_path = "parent"
    @parent = Path.new(@base_path, @parent_local_path, true)
    @children_relative_path = "child"
    @instance = Path.new(@parent, @children_relative_path)
  end

  it "should have a local_path starting with its parent local path" do
    @instance.local_path.should == File.join(@parent_local_path, @children_relative_path)
  end

  it "should have as a base_path the parent base_path" do
    @instance.base_path.should == @parent.base_path
  end

  it "should have a working child-parent relationship" do
    @instance.should be_child_of(@parent)
    @parent.should be_parent_of(@instance)
  end
end
