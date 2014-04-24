# encoding: utf-8

require 'forwardable'
require 'game2048/monkey_patch/array'

module Game2048
  # Each row or column of a game board.
  class Numbers
    extend Forwardable

    def initialize(numbers)
      @numbers = numbers.dup
    end

    def right
      @numbers.rshrink.rmerge.rshrink
    end

    def right!
      @numbers = right
    end

    def left
      @numbers.reverse.rshrink.rmerge.rshrink.reverse
    end

    def left!
      @numbers = left
    end

    def_delegators :@numbers, :map, :==
  end
end
