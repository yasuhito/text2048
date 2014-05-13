# encoding: utf-8

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'coveralls'
Coveralls.wear_merged!

require 'rspec'
require 'rspec/given'
