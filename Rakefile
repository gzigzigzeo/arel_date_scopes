require 'rake'
require 'rake/testtask'
require 'rspec/core'
require 'rspec/core/rake_task'
require 'arel_date_scopes'
require 'bundler'

Bundler::GemHelper.install_tasks
RSpec::Core::RakeTask.new(:spec)
task :default => :spec