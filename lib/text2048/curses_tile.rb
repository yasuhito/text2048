# encoding: utf-8

require 'curses'

module Text2048
  # Shows tiles in curses.
  class CursesTile
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
      attron(color_pair(@color)) { fill }
      self
    end

    def flash
      attron(color_pair(COLOR_YELLOW)) { draw_box }
      refresh
      sleep 0.2
      draw_box
      refresh
    end

    def zoom1
      attron(color_pair(COLOR_BLACK)) { fill }
      refresh

      setpos(yc + 1, xc + 2)
      attron(color_pair(@color)) { addstr("#{@value}") }
      refresh
    end

    def zoom2
      setpos(yc, xc + 1)
      attron(color_pair(@color)) { addstr('   ') }
      setpos(yc + 1, xc + 1)
      attron(color_pair(@color)) { addstr(" #{@value} ") }
      setpos(yc + 2, xc + 1)
      attron(color_pair(@color)) { addstr('   ') }
      refresh
    end

    def zoom3
      attron(color_pair(@color)) { fill }
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
          addstr(' ' * @width)
        end
      end
    end
  end
end
