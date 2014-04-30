# encoding: utf-8

require 'curses'

module Text2048
  # Curses UI
  class CursesView
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
      2048 => COLOR_RED
    }
    COLOR_BOX = 16

    def init
      init_screen
      curs_set(0)
      start_color
      stdscr.keypad(true)
      noecho
      COLORS.each_pair do |_key, value|
        init_pair value, COLOR_BLACK, value
      end
      init_pair COLOR_BOX, COLOR_WHITE, COLOR_BLACK
      at_exit { close_screen }
    end

    def draw(layout, score)
      draw_score(score)
      layout.each_with_index do |row, y|
        draw_row(row, y)
      end
    end

    def flash_tile(_number, y, x)
      draw_box(color_pair(COLOR_YELLOW), y, x)
      refresh
      sleep 0.5
      draw_box(color_pair(COLOR_BOX), y, x)
      refresh
    end

    private

    def draw_score(score)
      setpos(0, 0)
      addstr("Score: #{score}")
    end

    def draw_box(color, y, x)
      cy = (TILE_HEIGHT + 1) * y + 2
      cx = (TILE_WIDTH + 1) * x + 1

      attron(color) do
        setpos(cy - 1, cx - 1)
        addstr('+-----+')
        setpos(cy, cx - 1)
        addstr('|')
        setpos(cy, cx + TILE_WIDTH)
        addstr('|')
        setpos(cy + 1, cx - 1)
        addstr('|')
        setpos(cy + 1, cx + TILE_WIDTH)
        addstr('|')
        setpos(cy + 2, cx - 1)
        addstr('|')
        setpos(cy + 2, cx + TILE_WIDTH)
        addstr('|')
        setpos(cy + 3, cx - 1)
        addstr('+-----+')
      end
    end

    def draw_row(numbers, y)
      numbers.each_with_index do |each, x|
        draw_box(color_pair(COLOR_BOX), y, x)
        draw_tile(each, y, x)
        refresh
      end
    end

    def draw_tile(number, y, x)
      cy = (TILE_HEIGHT + 1) * y + 2
      cx = (TILE_WIDTH + 1) * x + 1

      attron(color_pair(COLORS[number]) | A_BOLD) do
        setpos(cy, cx)
        addstr(' ' * TILE_WIDTH)
        setpos(cy + 1, cx)
        addstr(number != 0 ? number.to_s.center(TILE_WIDTH) : ' ' * TILE_WIDTH)
        setpos(cy + 2, cx)
        addstr(' ' * TILE_WIDTH)
      end
    end
  end
end
