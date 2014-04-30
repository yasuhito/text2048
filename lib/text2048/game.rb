# encoding: utf-8

require 'forwardable'
require 'text2048/board'

module Text2048
  # A class responsible of handling all the command line interface
  # logic.
  class Game
    attr_reader :score

    extend Forwardable

    def initialize(view, layout = nil)
      @score = 0
      @board = Board.new(layout)
      @view = view
    end

    def start
      @view.start
    end

    def draw
      @view.update(@board.layout, @score)
      @view.flash_tile(*@new_tile) if @new_tile
    end

    def lose?
      false
    end

    def input(command)
      @new_tile = nil
      last = @board.layout.dup
      __send__ command
      return if last == @board.layout
      @new_tile = @board.generate
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
      @view.larger!(@board.layout, @score)
    end

    def smaller!
      @view.smaller!(@board.layout, @score)
    end

    def quit
      exit 0
    end
  end
end
