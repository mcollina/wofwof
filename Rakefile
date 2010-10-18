require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "wofwof"
    gem.summary = %Q{WofWof is a static website generator.}
    gem.description = %Q{bla bla}
    gem.email = "matteo.collina@gmail.com"
    gem.homepage = "http://github.com/mcollina/wofwof"
    gem.authors = ["Matteo Collina"]
    gem.add_dependency "liquid", "~> 2.2"
    gem.add_dependency "kramdown", "~> 0.10"
    gem.add_development_dependency "rspec", "~> 2.0"
    gem.add_development_dependency "rcov", "~> 0.9"
    gem.add_development_dependency "cucumber", "~> 0.8"
    gem.add_development_dependency "autotest", "~> 4.4"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

rcov_opts = ["--text-summary", "--exclude","lib\/rspec,bin\/rspec,config\/boot.rb,lib\/rcov," + 
             "spec,liquid,kramdown,diff-lcs,lib\/cucumber,lib\/gherkin,cucumber,lib\/term,features"]
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |spec|
  end

  RSpec::Core::RakeTask.new(:rcov) do |spec|
    spec.rcov = true
    spec.rcov_opts = rcov_opts
  end
rescue LoadError
  task :spec
  task :rcov
end

task :spec => :check_dependencies
task :rcov => :check_dependencies

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features) do |cukes|
    cukes.rcov = true
    cukes.rcov_opts = rcov_opts
  end
rescue LoadError
  task :features 
end

task :features => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "wofwof #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :autotest => :check_dependencies do
  exec "autotest"
end
