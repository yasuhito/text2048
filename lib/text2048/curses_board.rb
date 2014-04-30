# encoding: utf-8

require 'curses'

module Text2048
  # Curses UI
  class CursesBoard
    include Curses

    TILE_HEIGHT = 3
    TILE_WIDTH = 5

    COLORS = {
      0 => COLOR_BLACK,
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
      2048 => COLOR_MAGENTA
    }

    def init
      init_screen
      curs_set(0)
      start_color
      stdscr.keypad(true)
      noecho
      COLORS.each_pair do |_key, value|
        init_pair value, COLOR_BLACK, value
      end
      at_exit { close_screen }
    end

    def draw(layout, score)
      draw_score(score)
      layout.each_with_index do |row, y|
        draw_row(row, y)
      end
    end

    private

    def draw_score(score)
      setpos(0, 0)
      addstr("Score: #{score}")
    end

    def draw_row(numbers, y)
      numbers.each_with_index do |each, x|
        draw_tile(each, y, x)
        refresh
      end
    end

    def draw_tile(number, y, x)
      y = (TILE_HEIGHT + 1) * y + 2
      x = (TILE_WIDTH + 1) * x + 1

      color = color_pair(COLORS[number]) | A_BOLD

      setpos(y - 1, x - 1)
      addstr('+-----+')

      setpos(y, x - 1)
      addstr('|')
      attron(color) do
        setpos(y, x)
        addstr(' ' * TILE_WIDTH)
      end
      setpos(y, x + TILE_WIDTH)
      addstr('|')

      setpos(y + 1, x - 1)
      addstr('|')
      attron(color) do
        setpos(y + 1, x)
        addstr(number != 0 ? number.to_s.center(TILE_WIDTH) : ' ' * TILE_WIDTH)
      end
      setpos(y + 1, x + TILE_WIDTH)
      addstr('|')

      setpos(y + 2, x - 1)
      addstr('|')
      attron(color) do
        setpos(y + 2, x)
        addstr(' ' * TILE_WIDTH)
      end
      setpos(y + 2, x + TILE_WIDTH)
      addstr('|')

      setpos(y + 3, x - 1)
      addstr('+-----+')
    end
  end
end
