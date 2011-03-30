require 'rake'
require 'rake/testtask'
require 'rspec/core'
require 'rspec/core/rake_task'
require 'acts_as_sequence'
require 'bundler'

Bundler::GemHelper.install_tasks
RSpec::Core::RakeTask.new(:spec)
task :default => :spec