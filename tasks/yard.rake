# encoding: utf-8

begin
  require 'yard'

  YARD::Rake::YardocTask.new do |t|
    t.options = ['--no-private']
    t.options << '--debug' << '--verbose' if verbose == true
  end

  desc 'Enumerate TODO items'
  task 'yard:todo' do
    YARD::Registry.load!.all.each do |each|
      puts each.tag(:todo).text if each.tag(:todo)
    end
  end
rescue LoadError
  task :yard do
    $stderr.puts 'YARD is disabled'
  end

  task 'yard:todo' do
    $stderr.puts 'YARD is disabled'
  end
end
