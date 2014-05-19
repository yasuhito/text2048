# encoding: utf-8

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  class CursesView
    # Renders numbers like LCDs
    class LCD
      BITMAPS = [
        0b111111110101011,
        0b101010010001000,
        0b111111100111001,
        0b111111110011001,
        0b101111010011010,
        0b111111110010011,
        0b111111110110011,
        0b101011010001001,
        0b111111110111011,
        0b111111110011011
      ]

      TOP = 0
      TOP_LEFT = 1
      TOP_MIDDLE = 2
      TOP_RIGHT = 3
      MIDDLE = 4
      BOTTOM_LEFT = 5
      BOTTOM_MIDDLE = 6
      BOTTOM_RIGHT = 7
      BOTTOM = 8

      CORNER_TOP_LEFT = 9
      CORNER_TOP_RIGHT = 10
      CORNER_MIDDLE_LEFT = 11
      CORNER_MIDDLE_RIGHT = 12
      CORNER_BOTTOM_LEFT = 13
      CORNER_BOTTOM_RIGHT = 14

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
           [TOP_LEFT, TOP_MIDDLE, TOP_RIGHT],
           [CORNER_MIDDLE_LEFT, MIDDLE, CORNER_MIDDLE_RIGHT],
           [BOTTOM_LEFT, BOTTOM_MIDDLE, BOTTOM_RIGHT],
           [CORNER_BOTTOM_LEFT, BOTTOM, CORNER_BOTTOM_RIGHT]]
        lines.map { |each| line(BITMAPS[number.to_i], each) }
      end

      # @todo This method smells of :reek:UtilityFunction
      # @todo This method smells of :reek:FeatureEnvy
      def line(bitmap, bits)
        bits.map { |each| (bitmap & 1 << each).zero? ? ' ' : '*' }.join
      end
    end
  end
end
