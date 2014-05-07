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
        list.each { |each| @tiles[each].__send__ name }
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
      @tiles = {}
      @scale = 2
      @scale_min = 1
      @scale_step = 0.5
    end

    def update(board)
      maybe_init_curses
      draw_score(board.score)
      draw_tiles(board.to_a)
      refresh
    end

    def height
      (CursesTile.height(@scale) + 1) * 4 + 1
    end

    def width
      (CursesTile.width(@scale) + 1) * 4 + 1
    end

    def larger(board)
      rwidth = (Curses.cols - 1) / DEFAULT_WIDTH
      rheight = Curses.lines / DEFAULT_HEIGHT
      return if @scale > [rwidth, rheight].min
      change_scale(board, @scale_step)
    end

    def smaller(board)
      return if @scale <= @scale_min
      change_scale(board, -1 * @scale_step)
    end

    def win
      setpos(rows_center, cols_center - 1)
      attron(color_pair(COLOR_RED)) { addstr('WIN!') }
    end

    def game_over
      setpos(rows_center, cols_center - 4)
      attron(color_pair(COLOR_RED)) { addstr('GAME OVER') }
    end

    private

    def change_scale(board, scale_step)
      maybe_init_curses
      @scale += scale_step
      clear
      update(board)
    end

    def rows_center
      height / 2
    end

    def cols_center
      width / 2
    end

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

    def draw_score(score)
      setpos(0, 0)
      addstr("Score: #{score}")
    end

    def draw_tiles(tiles)
      [0, 1, 2, 3].product([0, 1, 2, 3]).each do |row, col|
        tile = tiles[row][col]
        @tiles[[row, col]] =
          CursesTile.new(tile, row, col, COLORS[tile.to_i], @scale).show
        refresh
      end
    end
  end
end
