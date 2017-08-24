# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'text2048/version'

Gem::Specification.new do |gem|
  gem.name = 'text2048'
  gem.version = Text2048::VERSION
  gem.summary = 'Text mode 2048 game.'
  gem.description = 'Text mode 2048 game in Ruby.'

  gem.license = 'GPL3'

  gem.authors = ['Yasuhito Takamiya']
  gem.email = ['yasuhito@gmail.com']
  gem.homepage = 'http://github.com/yasuhito/text2048'

  gem.files = %w[LICENSE Rakefile text2048.gemspec]
  gem.files += Dir.glob('lib/**/*.rb')
  gem.files += Dir.glob('bin/**/*')
  gem.files += Dir.glob('spec/**/*')

  gem.executables = ['2048']
  gem.require_paths = ['lib']

  gem.extra_rdoc_files =
    [
      'CONTRIBUTING.md',
      'README.md',
      'LICENSE'
    ]
  gem.test_files = Dir.glob('spec/**/*')
  gem.test_files += Dir.glob('features/**/*')

  gem.required_ruby_version = '>= 1.9.3'

  gem.add_dependency 'curses', '~> 1.0.1'

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rake', '~> 10.4.2'

  # guard
  gem.add_development_dependency 'guard', '~> 2.10.1'
  gem.add_development_dependency 'guard-bundler', '~> 2.0.0'
  gem.add_development_dependency 'guard-cucumber', '~> 1.5.1'
  gem.add_development_dependency 'guard-rspec', '~> 4.3.1'

  # docs
  gem.add_development_dependency 'inch', '~> 0.5.7'
  gem.add_development_dependency 'yard', '~> 0.8.7.6'

  # test
  gem.add_development_dependency 'codeclimate-test-reporter'
  gem.add_development_dependency 'coveralls', '~> 0.7.2'
  gem.add_development_dependency 'cucumber', '~> 1.3.17'
  gem.add_development_dependency 'flay', '~> 2.5.0'
  gem.add_development_dependency 'flog', '~> 4.3.0'
  gem.add_development_dependency 'reek', '~> 4.7.2'
  gem.add_development_dependency 'rspec-given', '~> 3.5.4'
  gem.add_development_dependency 'rubocop', '~> 0.49.1'
end
