# encoding: utf-8

require 'forwardable'

module Text2048
  # 2048 tile
  class Tile
    attr_reader :status

    extend Forwardable

    def initialize(value, status = nil)
      @value = value
      @status = status
    end

    def ==(other)
      @value == other.to_i
    end

    def_delegators :@value, :to_i, :to_s
  end
end
