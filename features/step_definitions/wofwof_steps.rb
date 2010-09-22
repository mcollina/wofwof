require 'tmpdir'

Given /a new project/ do
  @website_dest = Dir.mktmpdir("wofwof") # TODO add the scenario name in the feature?
  @runtime = WofWof::Runtime.new
  @runtime.dest_path_handler = WofWof::FileSystemPathHandler.new(WofWof::Path.new(@website_dest, ""))
  #Kernel.at_exit { Dir.rmdir @website_dest } # TODO add a way to skip deletion
end

Given /^the liquid template folder (.*)$/ do |path|
  @runtime.sources << WofWof::LiquidTemplateSource.new(WofWof::FileSystemPathHandler.new(WofWof::Path.new(
    File.join(File.dirname(__FILE__), "../", path), "")))
end

Given /^the pages folder (.*)$/ do |path|
  @runtime.sources << WofWof::PageSource.new(WofWof::FileSystemPathHandler.new(WofWof::Path.new(
    File.join(File.dirname(__FILE__), "../", path), "")))
end

When /^I render the website$/ do
  @runtime.render
end

Then /^everyone should see that there is an (.*) file$/ do |file|
  File.should be_exists(File.join(@website_dest, file))
end

Then /^that the (.*) file contains the text in (.*)$/ do |destination, source|
  open(File.join(@website_dest,destination), "r") do |dest_io|
    open(File.join(File.dirname(__FILE__), "../", source), "r") do |source_io|
      dest_io.read.should =~ /#{source_io.read}/
    end
  end
end
