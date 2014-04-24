require 'text2048/numbers'

module Text2048
  # Game board
  class Board
    def initialize(layout = nil)
      @data = [[0, 0, 0, 0],
               [0, 0, 0, 0],
               [0, 0, 0, 0],
               [0, 0, 0, 0]]
      if layout
        load_layout(layout)
      else
        set_random_numbers
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

    private

    def load_layout(layout)
      layout.each_with_index do |row, y|
        row.each_with_index do |number, x|
          @data[y][x] = number
        end
      end
    end

    def set_random_numbers
      n = 0
      loop do
        return if n == 2
        x = rand(4).to_i
        y = rand(4).to_i
        if @data[y][x] == 0
          @data[y][x] = (rand(2) == 0 ? 2 : 4)
          n += 1
        end
      end
    end
  end
end
