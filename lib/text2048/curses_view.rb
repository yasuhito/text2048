# encoding: utf-8

require 'curses'

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
    COLOR_BOX = 16

    class Tile
      include Curses

      DEFAULT_HEIGHT = 3
      DEFAULT_WIDTH = 5

      def initialize(number, y, x, scale = 1)
        @number = number
        @y = y
        @x = x
        @height = (DEFAULT_HEIGHT * scale).to_i
        @width = (DEFAULT_WIDTH * scale).to_i
      end

      def show
        attron(color_pair(COLOR_BOX)) { draw_box }
        attron(color_pair(COLORS[@number])) { fill }
        self
      end

      def flash
        attron(color_pair(COLOR_YELLOW)) { draw_box }
        refresh
        sleep 0.2
        attron(color_pair(COLOR_BOX)) { draw_box }
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
      end
      init_pair COLOR_BOX, COLOR_WHITE, COLOR_BLACK
      at_exit { close_screen }
    end

    def update(layout, score)
      draw_score(score)
      layout.each_with_index do |row, y|
        draw_row(row, y)
      end
    end

    def larger!(layout, score)
      @scale += 0.5
      clear
      update(layout, score)
    end

    def smaller!(layout, score)
      @scale -= 0.5
      clear
      update(layout, score)
    end

    def flash_tile(y, x)
      @tiles[y][x].flash
    end

    private

    def draw_score(score)
      setpos(0, 0)
      addstr("Score: #{score}")
    end

    def draw_row(numbers, y)
      numbers.each_with_index do |each, x|
        @tiles[y][x] = Tile.new(each, y, x, @scale).show
      end
      refresh
    end
  end
end
