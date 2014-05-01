# encoding: utf-8

module Text2048
  class Tile
    attr_reader :status
    attr_accessor :value

    def initialize(value, status = nil)
      @value = value
      @status = status
    end

    def to_i
      @value
    end

    def to_s
      @value.to_s
    end

    def *(number)
      @value *= number
    end

    def ==(other)
      @value == other.to_i
    end
  end
end
