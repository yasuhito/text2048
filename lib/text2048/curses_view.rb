# encoding: utf-8

require 'curses'
require 'text2048/curses_tile'

# This module smells of :reek:UncommunicativeModuleName
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

    DEFAULT_WIDTH = (CursesTile::DEFAULT_WIDTH + 1) * 4 + 1
    DEFAULT_HEIGHT = (CursesTile::DEFAULT_HEIGHT + 1) * 4 + 2

    def initialize
      @tiles = Array.new(4) { Array.new(4) }
      @scale = 2
      @scale_min = 1
      @scale_step = 0.5
    end

    def start
      init_screen
      curs_set(0)
      start_color
      stdscr.keypad(true)
      noecho
      init_color_pairs
      at_exit { close_screen }
    end

    def update(tiles, score)
      draw_score(score)
      tiles.each_with_index { |row, line| draw_row(row, line) }
    end

    def larger!(tiles, score)
      return if @scale > scale_max
      @scale += @scale_step
      clear
      update(tiles, score)
    end

    def smaller!(tiles, score)
      return if @scale <= @scale_min
      @scale -= @scale_step
      clear
      update(tiles, score)
    end

    def pop_tiles(list)
      list.each do |line, col|
        @tiles[line][col].pop
      end
      refresh
      sleep 0.1

      list.each do |line, col|
        @tiles[line][col].draw_box
      end
      refresh
    end

    def zoom_tiles(list)
      [:fill_black, :draw_number, :show].each do |each|
        list.each { |line, col| @tiles[line][col].__send__ each }
        refresh
        sleep 0.05
      end
    end

    def game_over
      setpos(height / 2, width / 2 - 4)
      attron(color_pair(COLOR_RED)) { addstr('GAME OVER') }
    end

    private

    def width
      (@tiles[0][0].width + 1) * 4 + 1
    end

    def height
      (@tiles[0][0].height + 1) * 4 + 2
    end

    def init_color_pairs
      COLORS.each_pair do |_key, value|
        init_pair value, COLOR_BLACK, value
        init_pair value + 100, value, value
      end
    end

    def scale_max
      ratio_width = (cols - 1) / DEFAULT_WIDTH
      ratio_height = lines / DEFAULT_HEIGHT
      ratio_width < ratio_height ? ratio_width : ratio_height
    end

    def draw_score(score)
      setpos(0, 0)
      addstr("Score: #{score}")
    end

    def draw_row(tiles, line)
      tiles.each_with_index do |each, col|
        @tiles[line][col] =
          CursesTile.new(each, line, col, COLORS[each.to_i], @scale).show
      end
      refresh
    end
  end
end
