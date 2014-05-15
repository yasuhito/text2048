# encoding: utf-8

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  class CursesView
    # Renders numbers like LCDs
    class LCD
      BITMAPS = [
        0b1111111110111,
        0b1010100100100,
        0b1111111011101,
        0b1111111101101,
        0b1011110101110,
        0b1111111101011,
        0b1111111111011,
        0b1010110100101,
        0b1111111111111,
        0b1111111101111
      ]

      TOP = 0
      TOP_LEFT = 1
      TOP_RIGHT = 2
      MIDDLE = 3
      BOTTOM_LEFT = 4
      BOTTOM_RIGHT = 5
      BOTTOM = 6

      CORNER_TOP_LEFT = 7
      CORNER_TOP_RIGHT = 8
      CORNER_MIDDLE_LEFT = 9
      CORNER_MIDDLE_RIGHT = 10
      CORNER_BOTTOM_LEFT = 11
      CORNER_BOTTOM_RIGHT = 12

      def initialize(number)
        @number = number
      end

      def render
        digits = @number.to_s.split(//).map { |each| digit(each) }
        digits.transpose.map { |each| each.join(' ') }.join("\n")
      end

      private

      def digit(number)
        lines =
          [[CORNER_TOP_LEFT, TOP, CORNER_TOP_RIGHT],
           [TOP_LEFT, nil, TOP_RIGHT],
           [CORNER_MIDDLE_LEFT, MIDDLE, CORNER_MIDDLE_RIGHT],
           [BOTTOM_LEFT, nil, BOTTOM_RIGHT],
           [CORNER_BOTTOM_LEFT, BOTTOM, CORNER_BOTTOM_RIGHT]]
        lines.map { |each| line(BITMAPS[number.to_i], each) }
      end

      # @todo This method smells of :reek:UtilityFunction
      # @todo This method smells of :reek:FeatureEnvy
      def line(bitmap, bits)
        bits.map do |each|
          if each
            (bitmap & 1 << each).zero? ? ' ' : '*'
          else
            ' '
          end
        end.join
      end
    end
  end
end
