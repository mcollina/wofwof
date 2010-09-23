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
    gem.add_dependency "liquid", ">= 2.0.0"
    gem.add_dependency "kramdown", ">= 0.10.0"
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "rcov", ">= 0.9.7.1"
    gem.add_development_dependency "cucumber", ">= 0.8.5"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.rcov = true
  spec.rcov_opts = ["--exclude","lib\/spec,bin\/spec,config\/boot.rb,lib\/rcov,spec,liquid,kramdown"]
end

require 'spec/rake/verify_rcov'
RCov::VerifyTask.new(:verify_rcov => :rcov) do |spec|
  spec.threshold = 100
end

task :spec => :check_dependencies

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)

  task :features => :check_dependencies
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "wofwof #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
