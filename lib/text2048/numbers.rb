# encoding: utf-8

require 'forwardable'
require 'text2048/monkey_patch/array'

module Text2048
  # Each row or column of a game board.
  class Numbers
    extend Forwardable

    def initialize(numbers)
      @numbers = numbers.dup
    end

    def right
      numbers, score = @numbers.rshrink.rmerge
      [numbers.rshrink, score]
    end

    def left
      numbers, score = @numbers.reverse.rshrink.rmerge
      [numbers.rshrink.reverse, score]
    end

    def_delegators :@numbers, :map, :==
  end
end
