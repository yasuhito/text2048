# encoding: utf-8

require 'curses'
require 'text2048/curses_view/colorize'
require 'text2048/curses_view/lcd'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  class CursesView
    # Shows tiles in curses.
    # rubocop:disable ClassLength
    class Tile
      attr_reader :width
      attr_reader :height
      attr_reader :color

      include Colorize

      DEFAULT_HEIGHT = 7
      DEFAULT_WIDTH = 17

      def self.width(scale)
        @width = (DEFAULT_WIDTH * scale).to_i
      end

      def self.height(scale)
        (DEFAULT_HEIGHT * scale).to_i
      end

      def initialize(tile, row, col, color, scale = 1)
        klass = self.class
        @value = tile.value
        @height = klass.height(scale)
        @width = klass.width(scale)
        @row = (@height + 1) * row + 2
        @col = (@width + 1) * col + 1
        @color = color
        @scale = scale
      end

      def show
        draw_box
        fill_tile_color
        draw_number
        self
      end

      def pop
        colorize(@color + 100) do
          draw_box
        end
      end

      def draw_box
        draw_square
        [box_upper_left, box_upper_right,
         box_lower_left, box_lower_right].each do |row, col|
          setpos(row, col)
          addstr('+')
        end
      end

      def fill_tile_color
        colorize(@color + 100) { fill }
      end

      def fill_black
        colorize(COLOR_BLACK + 100) { fill }
        refresh
      end

      def draw_number
        return unless @value
        if @scale >= 1
          draw_lcd_number
        else
          setpos(@row + @height / 2, @col)
          colorize(@color) do
            addstr @value.to_s.center(@width)
          end
        end
      end

      private

      def draw_lcd_number
        num_lcd = LCD.new(@value).render
        num_lcd.split("\n").each_with_index do |each, index|
          draw_lcd_line(each, @row + index + (@height - 5) / 2)
        end
      end

      def col_padded
        num_length = @value.to_i.to_s.length
        @col + (@width - num_length * 4 + 1) / 2
      end

      # @todo This method smells of :reek:NestedIterators
      # @todo This method smells of :reek:TooManyStatements
      def draw_lcd_line(line, row)
        line.split(//).each_with_index do |each, index|
          setpos(row, col_padded + index)
          color = each == '*' ? COLOR_BLACK + 100 : @color
          colorize(color) { addstr each }
        end
      end

      def box_upper_left
        [@row - 1, @col - 1]
      end

      def box_upper_right
        [@row - 1, @col + @width]
      end

      def box_lower_left
        [@row + @height, @col - 1]
      end

      def box_lower_right
        [@row + @height, @col + @width]
      end

      def box_height
        @height + 2
      end

      def box_width
        @width + 2
      end

      def draw_square
        draw_horizonal_line(*box_upper_left, box_width)
        draw_vertical_line(*box_upper_left, box_height)
        draw_vertical_line(*box_upper_right, box_height)
        draw_horizonal_line(*box_lower_left, box_width)
      end

      def draw_horizonal_line(row, col, length)
        setpos(row, col)
        addstr('-' * length)
      end

      def draw_vertical_line(row, col, length)
        (0..(length - 1)).each do |each|
          setpos(row + each, col)
          addstr('|')
        end
      end

      def fill
        (0..(@height - 1)).each do |each|
          setpos(@row + each, @col)
          if @value && each == @height / 2
            addstr @value.to_s.center(@width)
          else
            addstr('.' * @width)
          end
        end
      end
    end
    # rubocop:enable ClassLength
  end
end
