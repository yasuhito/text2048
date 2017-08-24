# encoding: utf-8

require 'curses'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  class CursesView
    # Handles user inputs in curses
    class Keyboard
      include Curses

      KEYS = {
        'h' => :left, 'l' => :right, 'k' => :up, 'j' => :down,
        Key::LEFT => :left, Key::RIGHT => :right,
        Key::UP => :up, Key::DOWN => :down,
        '+' => :larger, '-' => :smaller,
        'q' => :quit
      }.freeze

      def read
        maybe_init
        KEYS[getch]
      end

      def wait_any_key
        getch
      end

      private

      def maybe_init
        return if @initialized
        noecho
        stdscr.keypad(true)
        @initialized = true
      end
    end
  end
end
