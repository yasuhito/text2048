# encoding: utf-8

require 'text2048/tile'
require 'text2048/tiles'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # Game board
  class Board
    attr_reader :score
    attr_reader :tiles

    def initialize(tiles = nil, score = 0)
      @score = score
      if tiles
        @tiles = tiles.to_h
      else
        @tiles = (Array.new(4) { Array.new(4) }).to_h
        2.times { generate }
      end
    end

    def initialize_copy(board)
      @tiles = board.tiles.dup
    end

    def to_a
      @tiles.reduce(Array.new(4) { Array.new(4) }) do |array, (key, value)|
        row, col = key
        array[row][col] = value && value.to_i
        array
      end
    end

    def win?
      @tiles.any? { |_key, value| value.to_i >= 2048 }
    end

    def lose?
      right.left.up.down.tiles.select do |_key, each|
        each.to_i > 0
      end.size == 4 * 4
    end

    def left
      tiles, score = move(:left)
      self.class.new tiles, @score + score
    end

    def right
      tiles, score = move(:right)
      self.class.new tiles, @score + score
    end

    def up
      tiles, score = transpose { move(:left) }
      self.class.new tiles, @score + score
    end

    def down
      tiles, score = transpose { move(:right) }
      self.class.new tiles, @score + score
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
        unless @tiles[sample]
          @tiles[sample] = Tile.new(rand < 0.8 ? 2 : 4, :generated)
          return
        end
      end
    end

    private

    def move(direction)
      to_a.reduce([[], 0]) do |memo, each|
        tiles, score = memo
        row, sc = Tiles.new(each).__send__ direction
        [tiles << row, score + sc]
      end
    end

    def find_tiles(status)
      @tiles.select { |_key, each| each && each.status == status }.keys
    end

    def transpose(&block)
      board = self.class.new(to_a.transpose, @score)
      tiles, score = board.instance_eval(&block)
      [tiles.transpose, score]
    end
  end
end
