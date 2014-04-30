# encoding: utf-8

require 'curses'

module Text2048
  class CursesTile
    include Curses

    DEFAULT_HEIGHT = 3
    DEFAULT_WIDTH = 5

    def initialize(number, y, x, color, scale = 1)
      @number = number
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
        if @number != 0 && dy == @height / 2
          addstr @number.to_s.center(@width)
        else
          addstr(' ' * @width)
        end
      end
    end
  end
end
