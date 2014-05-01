# encoding: utf-8

require 'forwardable'
require 'text2048/board'

module Text2048
  # A class responsible of handling all the command line interface
  # logic.
  class Game
    attr_reader :score

    extend Forwardable

    def initialize(view, tiles = nil)
      @score = 0
      @board = Board.new(tiles)
      @view = view
    end

    def start
      @view.start
    end

    def draw
      @view.update(@board.tiles, @score)
      @view.zoom_tile(*@board.new_tile) if @board.new_tile
    end

    def lose?
      b = @board.dup
      b.right!
      b.left!
      b.up!
      b.down!
      b.numbers.size == 4 * 4
    end

    def input(command)
      last = @board.tiles.dup
      __send__ command
      return if last == @board.tiles
      @board.generate
    end

    def left!
      @score += @board.left!
    end

    def right!
      @score += @board.right!
    end

    def up!
      @score += @board.up!
    end

    def down!
      @score += @board.down!
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
  end
end
