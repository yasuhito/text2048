# encoding: utf-8

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
