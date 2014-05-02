# encoding: utf-8

require 'curses'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # Shows tiles in curses.
  class CursesTile
    attr_reader :width
    attr_reader :height
    attr_reader :color

    include Curses

    DEFAULT_HEIGHT = 3
    DEFAULT_WIDTH = 5

    def initialize(value, y, x, color, scale = 1)
      @value = value.to_i
      @y = y
      @x = x
      @color = color
      @height = (DEFAULT_HEIGHT * scale).to_i
      @width = (DEFAULT_WIDTH * scale).to_i
    end

    def show
      draw_box
      fill_tile_color
      draw_number
      self
    end

    def pop
      attron(color_pair(@color + 100)) do
        draw_box
      end
    end

    def draw_box
      draw_square
      [[yc - 1, xc - 1],
       [yc - 1, xc + @width],
       [yc + @height, xc - 1],
       [yc + @height, xc + @width]].each do |y, x|
        setpos(y, x)
        addstr('+')
      end
    end

    def fill_tile_color
      attron(color_pair(@color + 100)) { fill }
    end

    def fill_black
      attron(color_pair(COLOR_BLACK + 100)) { fill }
      refresh
    end

    def draw_number
      return if @value == 0
      setpos(yc + @height / 2, xc)
      attron(color_pair(@color)) do
        addstr @value.to_s.center(@width)
      end
    end

    def zoom2
      setpos(yc + @height / 2 - 1, xc + @width / 2 - 1)
      attron(color_pair(@color + 100)) { addstr('...') }
      setpos(yc + @height / 2, xc + @width / 2 - 1)
      attron(color_pair(@color + 100)) { addstr('...') }
      setpos(yc + @height / 2 + 1, xc + @width / 2 - 1)
      attron(color_pair(@color + 100)) { addstr('...') }

      draw_number

      refresh
    end

    def zoom3
      attron(color_pair(@color + 100)) { fill }
      draw_number
      refresh
    end

    private

    def yc
      (@height + 1) * @y + 2
    end

    def xc
      (@width + 1) * @x + 1
    end

    def draw_square
      draw_horizonal_line(yc - 1, xc - 1, @width + 2)
      draw_vertical_line(yc, xc - 1, @height)
      draw_vertical_line(yc, xc + @width, @height)
      draw_horizonal_line(yc + @height, xc - 1, @width + 2)
    end

    def draw_horizonal_line(y, x, length)
      setpos(y, x)
      addstr('-' * length)
    end

    def draw_vertical_line(y, x, length)
      (0..(length - 1)).each do |dy|
        setpos(y + dy, x)
        addstr('|')
      end
    end

    def fill
      (0..(@height - 1)).each do |dy|
        setpos(yc + dy, xc)
        if @value != 0 && dy == @height / 2
          addstr @value.to_s.center(@width)
        else
          addstr('.' * @width)
        end
      end
    end
  end
end
