# encoding: utf-8

begin
  require 'rubocop/rake_task'

  Rubocop::RakeTask.new
rescue LoadError
  task :rubocop do
    $stderr.puts 'Rubocop is disabled'
  end
end
