# encoding: utf-8

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
