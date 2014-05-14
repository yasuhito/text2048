# encoding: utf-8

require 'curses'
require 'forwardable'
require 'text2048/curses_view/colorize'
require 'text2048/curses_view/keyboard'
require 'text2048/curses_view/lcd'
require 'text2048/curses_view/tile'
require 'text2048/curses_view/tile_effects'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # Curses UI
  class CursesView
    include Colorize
    include Curses
    include TileEffects
    extend Forwardable

    DEFAULT_WIDTH = (Tile::DEFAULT_WIDTH + 1) * 4 + 1
    DEFAULT_HEIGHT = (Tile::DEFAULT_HEIGHT + 1) * 4 + 2

    def initialize
      @tiles = {}
      @scale = 2
      @scale_min = 1
      @scale_step = 0.5
      @keyboard = Keyboard.new
    end

    def_delegator :@keyboard, :read, :command

    def update(board)
      maybe_init_curses
      draw_score(board.score)
      draw_tiles(board.to_a)
      refresh
    end

    def height
      (Tile.height(@scale) + 1) * 4 + 1
    end

    def width
      (Tile.width(@scale) + 1) * 4 + 1
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
      colorize(COLOR_RED) { addstr('WIN!') }
    end

    def game_over
      setpos(rows_center, cols_center - 4)
      colorize(COLOR_RED) { addstr('GAME OVER') }
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
      return if @initialized
      init_curses
      @initialized = true
    end

    def init_curses
      init_screen
      curs_set(0)
      at_exit { close_screen }
    end

    def draw_score(score)
      setpos(0, 0)
      addstr("Score: #{score}")
    end

    def draw_tiles(tiles)
      [0, 1, 2, 3].product([0, 1, 2, 3]).each do |row, col|
        tile = tiles[row][col]
        @tiles[[row, col]] =
          Tile.new(tile, row, col, color(tile.to_i), @scale).show
        refresh
      end
    end
  end
end
