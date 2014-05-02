# encoding: utf-8

require 'text2048/tile'
require 'text2048/tiles'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # Game board
  class Board
    attr_reader :tiles

    def initialize(tiles = nil)
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

    def right
      tiles, = move(:right)
      self.class.new tiles
    end

    def right!
      move! :right
    end

    def left
      tiles, = move(:left)
      self.class.new tiles
    end

    def left!
      move! :left
    end

    def up
      tiles, = transpose { move :left }
      self.class.new tiles
    end

    def up!
      transpose { move! :left }
    end

    def down
      tiles, = transpose { move :right }
      self.class.new tiles
    end

    def down!
      transpose { move! :right }
    end

    def ==(other)
      @tiles.zip(other.tiles).reduce(true) do |result, each|
        result && Tiles.new(each[0]) == Tiles.new(each[1])
      end
    end

    def merged_tiles
      find_tiles :merged
    end

    def generated_tiles
      find_tiles :generated
    end

    def generate
      loop do
        x = rand(4)
        y = rand(4)
        if @tiles[y][x] == 0
          @tiles[y][x] = Tile.new(rand < 0.8 ? 2 : 4, :generated)
          return
        end
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

    def move!(direction)
      @tiles, score = move(direction)
      score
    end

    def find_tiles(status)
      list = []
      @tiles.each_with_index do |row, y|
        row.each_with_index do |each, x|
          list << [y, x] if each.status == status
        end
      end
      list
    end

    def transpose
      @tiles = @tiles.transpose
      score = yield
      @tiles = @tiles.transpose
      score
    end
  end
end
