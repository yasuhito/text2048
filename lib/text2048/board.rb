# encoding: utf-8

require 'text2048/monkey_patch/array'
require 'text2048/tile'

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
      end
    end

    def initialize_copy(board)
      @tiles = board.tiles.dup
    end

    def to_a
      @tiles.reduce(Array.new(4) { Array.new(4) }) do |array, (key, value)|
        row, col = key
        array[row][col] = value
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
      numbers, score = move(:left)
      self.class.new numbers, @score + score
    end

    def right
      numbers, score = move(:right)
      self.class.new numbers, @score + score
    end

    def up
      numbers, score = transpose { move(:left) }
      self.class.new numbers, @score + score
    end

    def down
      numbers, score = transpose { move(:right) }
      self.class.new numbers, @score + score
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
      to_a.reduce([[], 0]) do |(board, score), each|
        row, row_score = __send__("row_#{direction}", each)
        [board << row, score + row_score]
      end
    end

    def row_right(row)
      clear_status(row).rshrink.rmerge
    end

    def row_left(row)
      list, score = clear_status(row).reverse.rshrink.rmerge
      [list.reverse, score]
    end

    def clear_status(row)
      row.map { |each| each && each.clear_status }
    rescue NoMethodError
      row.dup
    end

    def transpose(&block)
      board = self.class.new(to_a.transpose, @score)
      tiles, score = board.instance_eval(&block)
      [tiles.transpose, score]
    end

    def find_tiles(status)
      @tiles.select { |_key, each| each && each.status == status }.keys
    end
  end
end
