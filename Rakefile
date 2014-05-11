# encoding: utf-8

require 'bundler/gem_tasks'
require 'coveralls/rake/task'

task default: [:test, :reek, :flay, :rubocop]
task test: [:spec, :cucumber, 'coveralls:push']
task travis: :default

Coveralls::RakeTask.new

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new
rescue LoadError
  task :spec do
    $stderr.puts 'RSpec is disabled'
  end
end

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new
rescue LoadError
  task :cucumber do
    $stderr.puts 'Cucumber is disabled'
  end
end

begin
  require 'rubocop/rake_task'
  Rubocop::RakeTask.new
rescue LoadError
  task :rubocop do
    $stderr.puts 'Rubocop is disabled'
  end
end

begin
  require 'reek/rake/task'
  Reek::Rake::Task.new do |t|
    t.fail_on_error = true
    t.verbose = false
    t.reek_opts = '--quiet'
    t.source_files = FileList['lib/**/*.rb']
  end
rescue LoadError
  task :reek do
    $stderr.puts 'Reek is disabled'
  end
end

begin
  require 'rake/tasklib'
  require 'flay'
  require 'flay_task'

  FlayTask.new do |t|
    t.dirs = FileList['lib/**/*.rb'].map do |each|
      each[/[^\/]+/]
    end.uniq
    t.threshold = 0
    t.verbose = true
  end
rescue LoadError
  task :flay do
    $stderr.puts 'Flay is disabled'
  end
end
