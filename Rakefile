# encoding: utf-8

require 'bundler/gem_tasks'

task default: [:spec, :cucumber, :reek, :rubocop]

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
    t.fail_on_error = false
    t.verbose = false
    t.reek_opts = '--quiet'
    t.source_files = FileList['lib/**/*.rb']
  end
rescue LoadError
  task :reek do
    $stderr.puts 'Reek is disabled'
  end
end
