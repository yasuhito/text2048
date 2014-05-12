# encoding: utf-8

require 'text2048'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # Controller class.
  class App
    attr_reader :board
    attr_reader :view

    def initialize(view = CursesView.new, board = Board.new)
      @view = view
      @board = board
    end

    def generate(num_tiles = 1)
      num_tiles.times { @board = @board.generate }
      @view.update(@board)
      @view.zoom_tiles(@board.generated_tiles)
    end

    def step
      @view.win if @board.win?
      @view.game_over if @board.lose?
      input @view.command
    end

    private

    def input(command)
      case command
      when :larger, :smaller
        @view.__send__ command, @board
      when :left, :right, :up, :down
        move_and_generate(command)
      when :quit
        exit 0
      end
    end

    def move_and_generate(command)
      last = move(command)
      generate if @board.generate?(last)
    end

    def move(command)
      last = @board.dup
      @board = @board.__send__(command)
      @view.update(@board)
      @view.pop_tiles(@board.merged_tiles)
      last
    end
  end
end
