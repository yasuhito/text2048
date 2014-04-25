# encoding: utf-8

require 'curses'
require 'text2048/board'

module Text2048
  # A class responsible of handling all the command line interface
  # logic.
  class Game
    include Curses

    TILE_HEIGHT = 3
    TILE_WIDTH = 5

    KEYS = {
      'h' => :left!, 'l' => :right!, 'k' => :up!, 'j' => :down!,
      Key::LEFT => :left!, Key::RIGHT => :right!,
      Key::UP => :up!, Key::DOWN => :down!
    }

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

    def initialize(output = STDOUT)
      @board = Board.new
      @output = output
    end

    def start
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

    def show
      setpos(0, 0)
      addstr("Score: #{@board.score}")

      y = 2
      @board.layout.each do |row|
        show_row(row, y)
        y += TILE_HEIGHT + 1
      end

      setpos(y - 1, 0)
      addstr('+-----+-----+-----+-----+')

      setpos(y, 0)
      addstr('   Use arrow key or q    ')

      refresh
    end

    def lose?
      false
    end

    def input(input)
      last = @board.layout.dup
      quit if input == 'q'
      method = KEYS[input]
      if method
        @board.__send__ method
      else
        :ignore
      end
      return if last == @board.layout
      @board.generate
    end

    def quit
      exit 0
    end

    private

    def show_row(numbers, y)
      setpos(y - 1, 0)
      addstr('+-----+-----+-----+-----+')

      numbers.each_with_index do |each, index|
        show_tile(each, y, (TILE_WIDTH + 1) * index + 1)
      end
      refresh
    end

    def show_tile(number, y, x)
      color = color_pair(COLORS[number] || COLOR_YELLOW) | A_BOLD

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
    end
  end
end
