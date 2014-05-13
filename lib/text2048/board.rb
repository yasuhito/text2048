# encoding: utf-8

require 'text2048/monkey_patch/array'
require 'text2048/tile'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # 2048 game board
  class Board
    attr_reader :score

    def initialize(tiles = Array.new(4) { Array.new(4, 0) }, score = 0)
      @all_tiles = tiles.to_h
      @score = score
    end

    # @!group Move

    # @!macro [new] move
    #   Move the tiles to the $0.
    #   @return [Board] returns a new board

    # @macro move
    def right
      board, score = to_a.reduce([[], @score]) do |(rows, sc), each|
        row, row_sc = each.right
        [rows << row, sc + row_sc]
      end
      new_board(board, score)
    end

    # @macro move
    def left
      reverse.right.reverse
    end

    # @macro move
    def up
      transpose.left.transpose
    end

    # @macro move
    def down
      transpose.right.transpose
    end

    # @!endgroup

    def initialize_copy(board)
      @all_tiles = board.all_tiles.dup
    end

    # @!group Tiles

    attr_reader :all_tiles

    def tiles
      @all_tiles.select { |_key, each| each.to_i > 0 }
    end

    def merged_tiles
      find_tiles :merged
    end

    def generated_tiles
      find_tiles :generated
    end

    def [](coord)
      @all_tiles[coord]
    end

    def generate?(other)
      to_a != other.to_a
    end

    def generate
      new_board = dup
      new_board.all_tiles[sample_zero_tile] =
        Tile.new(rand < 0.8 ? 2 : 4, :generated)
      new_board
    end

    # @!endgroup

    # @!group Win/Lose

    def win?
      @all_tiles.any? { |_key, value| value.to_i >= 2048 }
    end

    def lose?
      right.left.up.down.tiles.size == 4 * 4
    end

    # @!endgroup

    # @!group Conversion

    def to_a
      [0, 1, 2, 3].map { |each| row(each) }
    end

    def reverse
      new_board(to_a.map(&:reverse), @score)
    end

    def transpose
      new_board(to_a.transpose, @score)
    end

    # @!endgroup

    private

    def sample_zero_tile
      zero_tiles = @all_tiles.select { |_key, each| each.to_i == 0 }
      fail if zero_tiles.empty?
      zero_tiles.keys.shuffle.first
    end

    def new_board(tiles, score)
      self.class.new(tiles, score)
    end

    def find_tiles(status)
      @all_tiles.select { |_key, each| each.status == status }.keys
    end

    def row(index)
      [index].product([0, 1, 2, 3]).map { |each| @all_tiles[each] }
    end
  end
end
