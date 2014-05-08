# encoding: utf-8

require 'text2048/monkey_patch/array'
require 'text2048/tile'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # Game board
  class Board
    attr_reader :score
    attr_reader :tiles

    def initialize(tiles = Array.new(4) { Array.new(4, 0) }, score = 0)
      @tiles = tiles.to_h
      @score = score
    end

    def initialize_copy(board)
      @tiles = board.tiles.dup
    end

    def [](coord)
      @tiles[coord]
    end

    def to_a
      [0, 1, 2, 3].map { |each| row(each) }
    end

    def win?
      @tiles.any? { |_key, value| value.to_i >= 2048 }
    end

    def lose?
      right.left.up.down.tiles.select do |_key, each|
        each.to_i > 0
      end.size == 4 * 4
    end

    def right
      new_board, dscore = to_a.reduce([[], 0]) do |(board, score), each|
        row, row_score = each.rmerge
        [board << row, score + row_score]
      end
      self.class.new new_board, @score + dscore
    end

    def left
      reverse :right
    end

    def up
      transpose :left
    end

    def down
      transpose :right
    end

    def merged_tiles
      find_tiles :merged
    end

    def generated_tiles
      find_tiles :generated
    end

    def generate
      loop do
        sample = @tiles.keys.sample
        if @tiles[sample] == 0
          @tiles[sample] = Tile.new(rand < 0.8 ? 2 : 4, :generated)
          return
        end
      end
    end

    private

    def transpose(direction)
      klass = self.class
      board = klass.new(to_a.transpose, @score).__send__(direction)
      klass.new board.to_a.transpose, board.score
    end

    def reverse(direction)
      klass = self.class
      board = klass.new(to_a.map(&:reverse), @score).__send__(direction)
      klass.new board.to_a.map(&:reverse), board.score
    end

    def find_tiles(status)
      @tiles.select { |_key, each| each.status == status }.keys
    end

    def row(index)
      [index].product([0, 1, 2, 3]).map { |each| @tiles[each] }
    end
  end
end
