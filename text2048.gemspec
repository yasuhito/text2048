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

  gem.files = %w(LICENSE Rakefile text2048.gemspec)
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
  gem.add_development_dependency 'bundler', '~> 1.6.2'
end
