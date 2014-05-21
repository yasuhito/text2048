# encoding: utf-8

require 'forwardable'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # 2048 tile
  class Tile
    attr_reader :value
    attr_reader :status

    extend Forwardable

    def initialize(value, status = nil)
      @value = value
      @status = status
    end

    def clear_status
      @status = nil
      self
    end

    def merged?
      @status == :merged
    end

    def ==(other)
      @value.to_i == other.to_i
    end

    def_delegators :@value, :to_i, :to_s
  end
end
