task default: [:spec, :cucumber, :rubocop]

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
