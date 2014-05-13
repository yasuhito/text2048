# encoding: utf-8

source 'https://rubygems.org'

gem 'rake', '~> 10.3.0'
gem 'curses', '~> 1.0.1', platforms: [:ruby_21]

group :docs do
  gem 'inch', '~> 0.4.5'
  gem 'yard', '~> 0.8.7.4'
end

group :development do
  gem 'guard', '~> 2.6.0'
  gem 'guard-bundler', '~> 2.0.0'
  gem 'guard-cucumber', '~> 1.4.1'
  gem 'guard-rspec', '~> 4.2.8'
end

group :test do
  gem 'codeclimate-test-reporter', require: nil
  gem 'coveralls', '~> 0.7.0', require: false
  gem 'cucumber', '~> 1.3.14'
  gem 'flay', '~> 2.4.0'
  gem 'flog', '~> 4.2.0'
  gem 'reek', '~> 1.3.7'
  gem 'rspec-given', '~> 3.5.4'
  gem 'rubocop', '~> 0.21.0', require: false
end

gemspec
