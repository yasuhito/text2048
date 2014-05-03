# encoding: utf-8

require 'curses'
require 'text2048'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # Controller class.
  class App
    include Curses

    KEYS = {
      'h' => :left, 'l' => :right, 'k' => :up, 'j' => :down,
      Key::LEFT => :left, Key::RIGHT => :right,
      Key::UP => :up, Key::DOWN => :down,
      '+' => :larger, '-' => :smaller,
      'q' => :quit
    }

    def initialize
      @view = CursesView.new
      @board = Board.new
      @view.update(@board)
    end

    def start
      loop do
        @view.game_over if @board.lose?
        input KEYS[Curses.getch]
      end
    end

    private

    def input(command)
      case command
      when :left, :right, :up, :down
        move_and_generate(command)
      when :larger!, :smaller!
        @view.__send__ command, @board.tiles, @board.score
      when :quit
        exit 0
      end
    end

    def move_and_generate(command)
      last = move(command)
      generate if @board != last
    end

    def move(command)
      last = @board.dup
      @board = @board.__send__(command)
      last
    end

    def generate
      @board.generate
      @view.update(@board)
    end
  end
end
