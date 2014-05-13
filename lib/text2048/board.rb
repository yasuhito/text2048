# encoding: utf-8

require 'text2048/monkey_patch/array'
require 'text2048/tile'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # Game board
  class Board
    attr_reader :score
    attr_reader :all_tiles

    def initialize(tiles = Array.new(4) { Array.new(4, 0) }, score = 0)
      @all_tiles = tiles.to_h
      @score = score
    end

    def initialize_copy(board)
      @all_tiles = board.all_tiles.dup
    end

    def tiles
      @all_tiles.select { |_key, each| each.to_i > 0 }
    end

    def [](coord)
      @all_tiles[coord]
    end

    def to_a
      [0, 1, 2, 3].map { |each| row(each) }
    end

    def win?
      @all_tiles.any? { |_key, value| value.to_i >= 2048 }
    end

    def lose?
      right.left.up.down.tiles.size == 4 * 4
    end

    def generate?(other)
      to_a != other.to_a
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
      new_board = dup
      new_board.all_tiles[sample_zero_tile] =
        Tile.new(rand < 0.8 ? 2 : 4, :generated)
      new_board
    end

    private

    def sample_zero_tile
      zero_tiles = @all_tiles.select { |_key, each| each.to_i == 0 }
      fail if zero_tiles.empty?
      zero_tiles.keys.shuffle.first
    end

    def new_board(tiles, score)
      self.class.new(tiles, score)
    end

    def transpose(direction)
      board = new_board(to_a.transpose, @score).__send__(direction)
      new_board(board.to_a.transpose, board.score)
    end

    def reverse(direction)
      board = new_board(to_a.map(&:reverse), @score).__send__(direction)
      new_board(board.to_a.map(&:reverse), board.score)
    end

    def find_tiles(status)
      @all_tiles.select { |_key, each| each.status == status }.keys
    end

    def row(index)
      [index].product([0, 1, 2, 3]).map { |each| @all_tiles[each] }
    end
  end
end
