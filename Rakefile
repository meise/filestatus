# encoding: utf-8

require 'bundler/gem_tasks'
require 'rake'
require 'pathname'
require 'yard'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new

YARD::Rake::YardocTask.new('doc')

desc "Removes temporary project files"
task :clean do
  %w{doc coverage pkg .yardoc .rbx Gemfile.lock}.map{|name| Pathname.new(name) }.each do |path|
    path.rmtree if path.exist?
  end

  Pathname.glob('*.gem').each &:delete
  Pathname.glob('**/*.rbc').each &:delete
end