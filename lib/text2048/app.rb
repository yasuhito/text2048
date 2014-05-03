# encoding: utf-8

require 'curses'
require 'text2048'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # Controller class.
  class App
    include Curses

    KEYS = {
      'h' => :left!, 'l' => :right!, 'k' => :up!, 'j' => :down!,
      Key::LEFT => :left!, Key::RIGHT => :right!,
      Key::UP => :up!, Key::DOWN => :down!,
      '+' => :larger!, '-' => :smaller!,
      'q' => :quit
    }

    def initialize
      @view = CursesView.new
      @game = Game.new(Board.new, @view)
      @game.draw
    end

    def start
      loop do
        @view.game_over if @game.lose?
        input KEYS[Curses.getch]
      end
    end

    private

    def input(command)
      case command
      when :left!, :right!, :up!, :down!
        move_and_generate(command)
      when :larger!, :smaller!
        @view.__send__ command, @game.tiles, @game.score
      when :quit
        exit 0
      end
    end

    def move_and_generate(command)
      last = @game.dup
      @game.__send__ command
      @game.generate if @game != last
      @game.draw
    end
  end
end
