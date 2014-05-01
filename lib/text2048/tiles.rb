# encoding: utf-8

require 'forwardable'
require 'text2048/monkey_patch/array'
require 'text2048/tile'

module Text2048
  # Each row or column of a game board.
  class Tiles
    extend Forwardable

    def initialize(list)
      @list = list.map { |each| each.to_i }
    end

    def right
      list, score = @list.rshrink.rmerge
      result = list.rshrink.map { |each| Tile.new(each) }
      [result, score]
    end

    def left
      list, score = @list.reverse.rshrink.rmerge
      result = list.rshrink.reverse.map { |each| Tile.new(each) }
      [result, score]
    end

    def ==(other)
      rshrink == other.rshrink
    end

    def_delegators :@list, :map, :rshrink
  end
end
