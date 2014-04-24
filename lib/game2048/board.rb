require 'game2048/numbers'

module Game2048
  # Game board
  class Board
    def initialize(layout)
      @data = [[0, 0, 0, 0],
               [0, 0, 0, 0],
               [0, 0, 0, 0],
               [0, 0, 0, 0]]
      layout.each_with_index do |row, y|
        row.each_with_index do |number, x|
          @data[y][x] = number
        end
      end
    end

    def right!
      @data.each_with_index do |each, index|
        @data[index] = Numbers.new(each).right!
      end
    end

    def left!
      @data.each_with_index do |each, index|
        @data[index] = Numbers.new(each).left!
      end
    end

    def up!
      @data.transpose.each_with_index do |each, index|
        column = Numbers.new(each).left!
        0.upto(3).each { |y| @data[y][index] = column[y] }
      end
    end

    def down!
      @data.transpose.each_with_index do |each, index|
        column = Numbers.new(each).right!
        0.upto(3).each { |y| @data[y][index] = column[y] }
      end
    end

    def to_s
      @data.map do |row|
        row.map do |number|
          number != 0 ? number : '_'
        end.join
      end.join("\n")
    end
  end
end
