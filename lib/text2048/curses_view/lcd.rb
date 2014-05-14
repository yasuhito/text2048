# encoding: utf-8

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  class CursesView
    # Displays numbers like LCD
    class LCD
      DIGITS = [
        0b1110111,
        0b0100100,
        0b1011101,
        0b1101101,
        0b0101110,
        0b1101011,
        0b1111011,
        0b0100101,
        0b1111111,
        0b1101111
      ]
      TOP = 0
      TOP_LEFT = 1
      TOP_RIGHT = 2
      MIDDLE = 3
      BOTTOM_LEFT = 4
      BOTTOM_RIGHT = 5
      BOTTOM = 6

      def render(number)
        digits = number.to_s.scan(/./).map { |each| digit(each) }
        digits.transpose.map { |each| each.join(' ') }.join("\n")
      end

      private

      def digit(digit)
        digit = DIGITS[digit.to_i]
        horizontal(digit, TOP) +
          vertical(digit, TOP_LEFT, TOP_RIGHT) +
          horizontal(digit, MIDDLE) +
          vertical(digit, BOTTOM_LEFT, BOTTOM_RIGHT) +
          horizontal(digit, BOTTOM)
      end

      def horizontal(digit, bit)
        [' ' + line(digit, bit, '-') + ' ']
      end

      def vertical(digit, left_bit, right_bit)
        [line(digit, left_bit) + ' ' + line(digit, right_bit)]
      end

      # @todo This method smells of :reek:UtilityFunction
      # @todo This method smells of :reek:FeatureEnvy
      def line(digit, bit, char = '|')
        (digit & 1 << bit).zero? ? ' ' : char
      end
    end
  end
end
