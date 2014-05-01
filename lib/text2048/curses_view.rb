# encoding: utf-8

require 'curses'
require 'text2048/curses_tile'

module Text2048
  # Curses UI
  class CursesView
    include Curses

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

    def initialize
      @tiles = Array.new(4) { Array.new(4) }
      @scale = 1
    end

    def start
      init_screen
      curs_set(0)
      start_color
      stdscr.keypad(true)
      noecho
      COLORS.each_pair do |_key, value|
        init_pair value, COLOR_BLACK, value
        init_pair value + 100, value, value
      end
      at_exit { close_screen }
    end

    def update(tiles, score)
      draw_score(score)
      tiles.each_with_index do |row, y|
        draw_row(row, y)
      end
    end

    def larger!(tiles, score)
      @scale += 0.5
      clear
      update(tiles, score)
    end

    def smaller!(tiles, score)
      return if @scale <= 1.0
      @scale -= 0.5
      clear
      update(tiles, score)
    end

    def pop_tiles(list)
      list.each do |y, x|
        attron(color_pair(@tiles[y][x].color + 100)) do
          @tiles[y][x].pop1
        end
      end
      refresh
      sleep 0.1

      list.each do |y, x|
        @tiles[y][x].pop2
      end
    end

    def zoom_tiles(list)
      [:zoom1, :zoom2, :zoom3].each do |each|
        list.each do |y, x|
          @tiles[y][x].__send__ each
        end
        sleep 0.05
      end
    end

    def game_over
      setpos(0, 16)
      attron(color_pair(COLOR_RED)) { addstr('GAME OVER') }
    end

    private

    def draw_score(score)
      setpos(0, 0)
      addstr("Score: #{score}")
    end

    def draw_row(tiles, y)
      tiles.each_with_index do |each, x|
        @tiles[y][x] =
          CursesTile.new(each, y, x, COLORS[each.to_i], @scale).show
      end
      refresh
    end
  end
end
