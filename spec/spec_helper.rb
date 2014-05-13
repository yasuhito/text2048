# encoding: utf-8

require 'codeclimate-test-reporter'
require 'coveralls'
require 'simplecov'

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

formatters = [SimpleCov::Formatter::HTMLFormatter]

formatters << Coveralls::SimpleCov::Formatter if ENV['COVERALLS_REPO_TOKEN']
if ENV['CODECLIMATE_REPO_TOKEN']
  formatters << CodeClimate::TestReporter::Formatter
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[*formatters]

SimpleCov.start

require 'rspec'
require 'rspec/given'
