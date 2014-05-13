# encoding: utf-8

require 'bundler/gem_tasks'
require 'coveralls/rake/task'

task default: [:test, :reek, :flog, :flay, :rubocop]
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
  require 'flog'
  desc 'Analyze for code complexity'
  task :flog do
    flog = Flog.new(continue: true)
    flog.flog(*FileList['lib/**/*.rb'])
    threshold = 20

    bad_methods = flog.totals.select do |name, score|
      !(/##{flog.no_method}$/ =~ name) && score > threshold
    end
    bad_methods.sort { |a, b| a[1] <=> b[1] }.reverse.each do |name, score|
      printf "%8.1f: %s\n", score, name
    end
    unless bad_methods.empty?
      fail "#{bad_methods.size} methods have a complexity > #{threshold}"
    end
  end
rescue LoadError
  task :flog do
    $stderr.puts 'Flog is disabled'
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
