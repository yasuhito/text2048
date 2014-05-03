# encoding: utf-8

require 'text2048/board'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # A class responsible of handling all the command line interface
  # logic.
  class Game
    attr_reader :score

    def initialize(board = Board.new, score = 0)
      @board = board
      @score = score
    end

    def tiles
      @board.tiles
    end

    def merged_tiles
      @board.merged_tiles
    end

    def generated_tiles
      @board.generated_tiles
    end

    def layout
      @board.layout
    end

    def lose?
      @board.dup
        .right.left.up.down.numbers.size == 4 * 4
    end

    def left
      move :left
    end

    def left!
      move! :left
    end

    def right
      move :right
    end

    def right!
      move! :right
    end

    def up
      move :up
    end

    def up!
      move! :up
    end

    def down
      move :down
    end

    def down!
      move! :down
    end

    def generate
      @board.generate
    end

    private

    def move(direction)
      board = @board.dup
      score = board.__send__("#{direction}!")
      self.class.new(board, @score + score)
    end

    def move!(direction)
      @score += @board.__send__("#{direction}!")
    end
  end
end
