# encoding: utf-8

require 'text2048'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # Controller class.
  class App
    def initialize
      @view = CursesView.new
      @board = Board.new
    end

    def start
      generate 2
      loop do
        @view.win if @board.win?
        @view.game_over if @board.lose?
        input @view.user_command
      end
    end

    private

    def input(command)
      case command
      when :left, :right, :up, :down
        move_and_generate(command)
      when :larger, :smaller
        @view.__send__ command, @board
      when :quit
        exit 0
      end
    end

    def move_and_generate(command)
      last = move(command)
      generate if @board.to_a != last.to_a
    end

    def move(command)
      last = @board.dup
      @board = @board.__send__(command)
      @view.update(@board)
      @view.pop_tiles(@board.merged_tiles)
      last
    end

    def generate(num_tiles = 1)
      num_tiles.times { @board = @board.generate }
      @view.update(@board)
      @view.zoom_tiles(@board.generated_tiles)
    end
  end
end
