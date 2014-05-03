# encoding: utf-8

require 'text2048/board'
require 'text2048/curses_view'
require 'text2048/text_view'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # A class responsible of handling all the command line interface
  # logic.
  class Game
    attr_reader :score

    def initialize(board = Board.new, view = TextView.new, score = 0)
      @board = board
      @view = view
      @score = score
    end

    def draw
      @view.update(@board.tiles, @score)
      @view.pop_tiles(@board.merged_tiles)
      @view.zoom_tiles(@board.generated_tiles)
    end

    def layout
      @board.layout
    end

    def lose?
      @board.dup
        .right.left.up.down.numbers.size == 4 * 4
    end

    def input(command)
      @last = @board.tiles.dup
      __send__ command
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
      return if @last == @board.tiles
      @board.generate
    end

    def larger!
      @view.larger!(@board.tiles, @score)
    end

    def smaller!
      @view.smaller!(@board.tiles, @score)
    end

    def game_over
      @view.game_over
    end

    def quit
      exit 0
    end

    private

    def move(direction)
      board = @board.dup
      score = board.__send__("#{direction}!")
      self.class.new(board, @view, @score + score)
    end

    def move!(direction)
      @score += @board.__send__("#{direction}!")
    end
  end
end
