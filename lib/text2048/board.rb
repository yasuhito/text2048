# encoding: utf-8

require 'text2048/monkey_patch/array'
require 'text2048/monkey_patch/hash'
require 'text2048/tile'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # 2048 game board
  class Board
    # @return [Number] returns the current score
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
      flip_horizontal { right }
    end

    # @macro move
    def up
      transpose { left }
    end

    # @macro move
    def down
      transpose { right }
    end

    # @!endgroup

    # @!group Tiles

    # @return [Array<Tile>] the list of tiles
    def tiles
      @all_tiles.select { |_key, each| each.to_i > 0 }
    end

    # @return [Array] the list of +[row, col]+ of the merged tiles
    def merged_tiles
      find_tiles :merged
    end

    # @return [Array] the list of +[row, col]+ of the newly generated tiles
    def generated_tiles
      find_tiles :generated
    end

    # Need to generate a new tile?
    # @param other [Board] the previous {Board} object
    # @return [Boolean] generate a new tile?
    def generate?(other)
      to_a != other.to_a
    end

    # Generates a new tile
    # @return [Board] a new board
    def generate
      tiles = @all_tiles.dup
      tiles[sample_zero_tile] = Tile.new(rand < 0.8 ? 2 : 4, :generated)
      new_board(tiles, @score)
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

    # @return [Array] a 2D array of tiles.
    def to_a
      [0, 1, 2, 3].map { |each| row(each) }
    end

    # @!endgroup

    private

    def flip_horizontal(&block)
      board = flipped_board.instance_eval(&block)
      new_board(board.to_a.map(&:reverse), @score + board.score)
    end

    def flipped_board
      new_board(to_a.map(&:reverse), @score)
    end

    def transpose(&block)
      board = transposed_board.instance_eval(&block)
      new_board(board.to_a.transpose, @score + board.score)
    end

    def transposed_board
      new_board(to_a.transpose, @score)
    end

    def zero_tiles
      @all_tiles.select { |_key, each| each.to_i == 0 }
    end

    def sample_zero_tile
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
