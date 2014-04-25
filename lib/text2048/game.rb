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
            Key::LEFT => :left!, Key::RIGHT => :right!, Key::UP => :up!, Key::DOWN => :down!
           }

    COLORS = {
              0 => COLOR_BLUE,
              2 => COLOR_WHITE,
              4 => COLOR_GREEN,
              8 => COLOR_GREEN,
              16 => COLOR_YELLOW,
              32 => COLOR_YELLOW,
              64 => COLOR_YELLOW,
              128 => COLOR_CYAN,
              256 => COLOR_CYAN,
              512 => COLOR_CYAN,
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
      COLORS.each_pair do |key, value|
        init_pair value, COLOR_BLACK, value
      end
      at_exit { close_screen }
    end

    def show
      y = 0

      @board.layout.each do |row|
        show_row(row, y)
        y += TILE_HEIGHT + 1
      end

      refresh
    end

    def input(input)
      method = KEYS[input]
      if method
        @board.__send__ method
      else
        :ignore
      end
      @board.generate
    end

    private

    def show_row(numbers, y)
      numbers.each_with_index do |each, index|
        show_tile(each, y, (TILE_WIDTH + 1) * index)
      end
      refresh
    end

    def show_tile(number, y, x)
      color = color_pair(COLORS[number] || COLOR_YELLOW) | A_BOLD

      attron(color) do
        setpos(y, x)
        addstr(' ' * TILE_WIDTH)
        setpos(y + 1, x)
        addstr(number != 0 ? number.to_s.center(TILE_WIDTH) : ' ' * TILE_WIDTH)
        setpos(y + 2, x)
        addstr(' ' * TILE_WIDTH)
      end
    end
  end
end
