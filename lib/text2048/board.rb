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
        @tiles = tiles.dup
      else
        @tiles = Array.new(4) { Array.new(4) { Tile.new(0) } }
        2.times { generate }
      end
    end

    def initialize_copy(board)
      @tiles = board.tiles.dup
    end

    def layout
      @tiles.map do |row|
        row.map { |each| each.to_i }
      end
    end

    def win?
      numbers.select do |each|
        each.to_i >= 2048
      end.size > 0
    end

    def lose?
      right.left.up.down.numbers.size == 4 * 4
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

    def ==(other)
      layout == other.layout
    end

    def merged_tiles
      find_tiles :merged
    end

    def generated_tiles
      find_tiles :generated
    end

    def generate
      loop do
        line = @tiles.sample
        col = rand(4)
        next if line[col] != 0
        line[col] = Tile.new(rand < 0.8 ? 2 : 4, :generated)
        return
      end
    end

    def numbers
      tiles.reduce([]) do |result, row|
        result + row.select { |each| each != 0 }
      end
    end

    private

    def move(direction)
      score = 0
      tiles = @tiles.map do |each|
        row, sc = Tiles.new(each).__send__ direction
        score += sc
        row
      end
      [tiles, score]
    end

    def find_tiles(status)
      list = []
      @tiles.each_with_index do |row, line|
        row.each_with_index do |each, col|
          list << [line, col] if each.status == status
        end
      end
      list
    end

    # FIXME: this method is destructive.
    def transpose
      @tiles = @tiles.transpose
      @tiles, score = yield
      @tiles = @tiles.transpose
      [@tiles, score]
    end
  end
end
