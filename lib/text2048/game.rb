# encoding: utf-8

require 'forwardable'
require 'text2048/board'

module Text2048
  # A class responsible of handling all the command line interface
  # logic.
  class Game
    extend Forwardable

    def initialize(view)
      @board = Board.new
      @view = view
    end

    def start
      @view.init
    end

    def draw
      @view.draw(@board.layout, @board.score)
    end

    def lose?
      false
    end

    def input(command)
      last = @board.layout.dup
      __send__ command
      return if last == @board.layout
      @board.generate
    end

    def quit
      exit 0
    end

    def_delegators :@board, :left!, :right!, :up!, :down!
  end
end
