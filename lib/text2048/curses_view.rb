# encoding: utf-8

require 'curses'
require 'text2048/curses_tile'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # Curses UI
  class CursesView
    # Curses tile effects
    module TileEffects
      def pop_tiles(list)
        [:pop, :draw_box].each do |each|
          list_do each, list
          refresh
          sleep 0.1
        end
      end

      def zoom_tiles(list)
        [:fill_black, :draw_number, :show].each do |each|
          list_do each, list
          refresh
          sleep 0.05
        end
      end

      private

      def list_do(name, list)
        list.each { |line, col| @tiles[line][col].__send__ name }
      end
    end

    include Curses
    include TileEffects

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

    def update(board)
      maybe_init_curses
      draw_score(board.score)
      draw_tiles(board.tiles)
      refresh
    end

    def height
      (@tiles[0][0].height + 1) * 4 + 2
    end

    def width
      (@tiles[0][0].width + 1) * 4 + 1
    end

    def larger(board)
      return if @scale > scale_max
      maybe_init_curses
      @scale += @scale_step
      clear
      update(board)
    end

    def smaller(board)
      return if @scale <= @scale_min
      maybe_init_curses
      @scale -= @scale_step
      clear
      update(board)
    end

    def win
      setpos(height / 2, width / 2 - 1)
      attron(color_pair(COLOR_RED)) { addstr('WIN!') }
    end

    def game_over
      setpos(height / 2, width / 2 - 4)
      attron(color_pair(COLOR_RED)) { addstr('GAME OVER') }
    end

    private

    def maybe_init_curses
      @curses_initialized || init_curses
      @curses_initialized = true
    end

    def init_curses
      start_color
      init_color_pairs
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

    def draw_tiles(tiles)
      tiles.each_with_index { |row, line| draw_row(row, line) }
    end

    def draw_row(tiles, line)
      tiles.each_with_index do |each, col|
        @tiles[line][col] =
          CursesTile.new(each, line, col, COLORS[each.to_i], @scale).show
      end
    end
  end
end
