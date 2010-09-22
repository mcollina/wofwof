require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), 'shared_spec_node'))

require 'stringio'

describe PageNode do

  it_should_behave_like AllStandardNodes

  before(:each) do
    @source_path = mock "SourcePath"
    @dest_path = mock "DestPath"
    @source_path.should_receive(:change_ext).with("html").and_return(@dest_path)
    @path_handler = mock "PathHandler"
    @node_repository = mock "NodeRepository"
    @content = "the content"
    @path_handler.should_receive(:open).with(@source_path, "r").and_yield(StringIO.new(@content))
    @instance = PageNode.new(@node_repository, @source_path, @path_handler)
  end

  it "should have a constructor which accepts also a meta_info hash" do
    @instance = Node.new(@source_path, :hello => "world")
    @instance.meta_info.should == { :hello => "world" }
  end

  it "should not be a template" do
    @instance.should_not be_template
  end
  
  it "should not have a nil dest_path" do
    @instance.dest_path.should_not be_nil
  end

  it "should have the a dest path which is the source path but with the html extension" do
    @instance.dest_path.should == @dest_path
  end

  it "should have a content attribute reader" do
    @instance.should respond_to(:content)
  end

  it "should have a content attribute which is an hash" do
    @instance.content.should be_kind_of(Hash)
  end

  it "should have the default content stored as the main key in the hash" do
    @instance.content[:main].should == @content
  end

  it "should have a build method" do
    @instance.should respond_to(:build)
  end

  it "should build correctly against the default template" do
    result = mock "result"
    template = mock "template"
    template.should_receive(:render).with(@instance, { :main => "the content" }).and_return(result)
    
    @node_repository.should_receive(:default_template).and_return(template)

    io = mock "io"
    io.should_receive(:<<).with(result)

    @instance.build(io)
  end
 
  it "should build correctly against the default template with the meta_info" do

    @instance.meta_info[:author] = "me"

    result = mock "result"
    template = mock "template"
    template.should_receive(:render).with(@instance, { :main => "the content", :author => "me" }).and_return(result)
    
    @node_repository.should_receive(:default_template).and_return(template)

    io = mock "io"
    io.should_receive(:<<).with(result)

    @instance.build(io)
  end

  it "should build correctly against a custom template" do
    @instance.meta_info[:template] = "the template"

    result = mock "result"
    template = mock "template"
    template.should_receive(:render).with(@instance, { :main => "the content", :template => "the template" }).and_return(result)

    @node_repository.should_receive(:find_by_path!).with("the template").and_return(template)

    io = mock "io"
    io.should_receive(:<<).with(result)

    @instance.build(io)
  end

  describe "with a YAML header" do
    before(:each) do
      @source_path = mock "SourcePath"
      @dest_path = mock "DestPath"
      @source_path.should_receive(:change_ext).with("html").and_return(@dest_path)
      @path_handler = mock "PathHandler"
      @node_repository = mock "NodeRepository"
      @content = <<-CONTENT 
hello: world
author: me
---
the content
CONTENT
      @path_handler.should_receive(:open).with(@source_path, "r").and_yield(StringIO.new(@content))
      @instance = PageNode.new(@node_repository, @source_path, @path_handler)
    end

    it "should have the main content which contains only the main part" do
      @instance.content[:main].should == "the content\n"
    end

    it "should have the YAML part put inside the meta_info hash" do
      @instance.meta_info[:hello].should == "world"
      @instance.meta_info[:author].should == "me"
    end
  end

  describe "with a YAML header and two main parts" do
    before(:each) do
      @source_path = mock "SourcePath"
      @dest_path = mock "DestPath"
      @source_path.should_receive(:change_ext).with("html").and_return(@dest_path)
      @path_handler = mock "PathHandler"
      @node_repository = mock "NodeRepository"
      @content = <<-CONTENT 
hello: world
author: me
---
the content
--- summary
the summary
CONTENT
      @path_handler.should_receive(:open).with(@source_path, "r").and_yield(StringIO.new(@content))
      @instance = PageNode.new(@node_repository, @source_path, @path_handler)
    end

    it "should have the main content which contains only the main part" do
      @instance.content[:main].should == "the content\n"
    end

    it "should have the summary content which contains only the summary part" do
      @instance.content[:summary].should == "the summary\n"
    end

    it "should have the YAML part put inside the meta_info hash" do
      @instance.meta_info[:hello].should == "world"
      @instance.meta_info[:author].should == "me"
    end
  end

  describe "with two main parts" do
    before(:each) do
      @source_path = mock "SourcePath"
      @dest_path = mock "DestPath"
      @source_path.should_receive(:change_ext).with("html").and_return(@dest_path)
      @path_handler = mock "PathHandler"
      @node_repository = mock "NodeRepository"
      @content = <<-CONTENT 
the content
--- summary
the summary
CONTENT
      @path_handler.should_receive(:open).with(@source_path, "r").and_yield(StringIO.new(@content))
      @instance = PageNode.new(@node_repository, @source_path, @path_handler)
    end

    it "should have the main content which contains only the main part" do
      @instance.content[:main].should == "the content\n"
    end

    it "should have the summary content which contains only the summary part" do
      @instance.content[:summary].should == "the summary\n"
    end
  end 
end
