# encoding: utf-8

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  class CursesView
    # Displays numbers like LCD
    class LCD
      DIGITS = [
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

      def render(number)
        digits = number.to_s.scan(/./).map { |each| digit(each) }
        digits.transpose.map { |each| each.join(' ') }.join("\n")
      end

      private

      def digit(digit)
        digit = DIGITS[digit.to_i]
        horizontal(digit, CORNER_TOP_LEFT, TOP, CORNER_TOP_RIGHT) +
          vertical(digit, TOP_LEFT, TOP_RIGHT) +
          horizontal(digit, CORNER_MIDDLE_LEFT, MIDDLE, CORNER_MIDDLE_RIGHT) +
          vertical(digit, BOTTOM_LEFT, BOTTOM_RIGHT) +
          horizontal(digit, CORNER_BOTTOM_LEFT, BOTTOM, CORNER_BOTTOM_RIGHT)
      end

      # @todo This method smells of :reek:LongParameterList
      def horizontal(digit, left_bit, bit, right_bit)
        [corner(digit, left_bit) + line(digit, bit) + corner(digit, right_bit)]
      end

      def vertical(digit, left_bit, right_bit)
        [line(digit, left_bit) + ' ' + line(digit, right_bit)]
      end

      # @todo This method smells of :reek:UtilityFunction
      # @todo This method smells of :reek:FeatureEnvy
      def line(digit, bit)
        (digit & 1 << bit).zero? ? ' ' : '*'
      end
      alias_method :corner, :line
    end
  end
end
