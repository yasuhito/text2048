# encoding: utf-8

require 'curses'

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
      attron(color_pair(@color + 100)) { fill }
      attron(color_pair(@color)) { draw_number }
      self
    end

    def pop1
      setpos(yc - 1, xc - 1)
      addstr('.' * (@width + 2))

      (0..(@height - 1)).each do |dy|
        setpos(yc + dy, xc - 1)
        addstr('.')
        setpos(yc + dy, xc + @width)
        addstr('.')
      end

      setpos(yc + @height, xc - 1)
      addstr('.' * (@width + 2))
    end

    def pop2
      draw_box
      refresh
    end

    def zoom1
      attron(color_pair(COLOR_BLACK + 100)) { fill }
      attron(color_pair(@color)) { draw_number }
      refresh
    end

    def zoom2
      setpos(yc + @height / 2 - 1, xc + @width / 2 - 1)
      attron(color_pair(@color + 100)) { addstr('...') }
      setpos(yc + @height / 2, xc + @width / 2 - 1)
      attron(color_pair(@color + 100)) { addstr('...') }
      setpos(yc + @height / 2 + 1, xc + @width / 2 - 1)
      attron(color_pair(@color + 100)) { addstr('...') }

      attron(color_pair(@color)) { draw_number }

      refresh
    end

    def zoom3
      attron(color_pair(@color + 100)) { fill }
      attron(color_pair(@color)) { draw_number }
      refresh
    end

    private

    def yc
      (@height + 1) * @y + 2
    end

    def xc
      (@width + 1) * @x + 1
    end

    def draw_box
      setpos(yc - 1, xc - 1)
      addstr("+#{'-' * @width}+")

      (0..(@height - 1)).each do |dy|
        setpos(yc + dy, xc - 1)
        addstr('|')
        setpos(yc + dy, xc + @width)
        addstr('|')
      end

      setpos(yc + @height, xc - 1)
      addstr("+#{'-' * @width}+")
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

    def draw_number
      return if @value == 0
      setpos(yc + @height / 2, xc)
      addstr @value.to_s.center(@width)
    end
  end
end
