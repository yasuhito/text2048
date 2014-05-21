# encoding: utf-8

require 'curses'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  class CursesView
    # Colorize characters.
    module Colorize
      include Curses

      COLORS = {
        nil => COLOR_BLACK,
        0 => COLOR_WHITE,
        2 => COLOR_WHITE,
        4 => COLOR_GREEN,
        8 => COLOR_GREEN,
        16 => COLOR_CYAN,
        32 => COLOR_CYAN,
        64 => COLOR_BLUE,
        128 => COLOR_BLUE,
        256 => COLOR_YELLOW,
        512 => COLOR_YELLOW,
        1024 => COLOR_MAGENTA,
        2048 => COLOR_RED
      }

      def color(number)
        COLORS[number]
      end

      def colorize(color, &block)
        maybe_init_colors
        attron color_pair(color), &block
      end

      private

      def maybe_init_colors
        return if @colors_initialized
        init_colors
        @colors_initialized = true
      end

      def init_colors
        start_color
        COLORS.each_pair do |_key, value|
          init_pair value, COLOR_BLACK, value
          init_pair value + 100, value, value
        end
      end
    end
  end
end
