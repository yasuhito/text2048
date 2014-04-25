# encoding: utf-8

require 'forwardable'
require 'text2048/monkey_patch/array'

module Text2048
  # Each row or column of a game board.
  class Numbers
    extend Forwardable

    def initialize(list)
      @list = list.dup
    end

    def right
      list, score = @list.rshrink.rmerge
      [list.rshrink, score]
    end

    def left
      list, score = @list.reverse.rshrink.rmerge
      [list.rshrink.reverse, score]
    end

    def ==(other)
      rshrink == other.rshrink
    end

    def_delegators :@list, :map, :rshrink
  end
end
