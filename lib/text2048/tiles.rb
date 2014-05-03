# encoding: utf-8

require 'forwardable'
require 'text2048/monkey_patch/array'
require 'text2048/tile'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # Each row or column of a game board.
  class Tiles
    extend Forwardable

    def initialize(list)
      @list = list.map { |each| Tile.new(each) }
    end

    def right
      list, score = @list.rshrink.rmerge
      [list.rshrink, score]
    end

    def left
      list, score = @list.reverse.rshrink.rmerge
      [list.rshrink.reverse, score]
    end

    def_delegators :@list, :map, :rshrink
  end
end
