# encoding: utf-8

task default: [:test, :reek, :flog, :flay, :rubocop]
task test: [:spec, :cucumber, 'coveralls:push']
task travis: :default

Dir.glob('tasks/*.rake').each { |each| import each }
