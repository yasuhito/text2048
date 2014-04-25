require 'text2048/numbers'

module Text2048
  # Game board
  class Board
    attr_reader :layout

    def initialize(layout = nil)
      @layout = Array.new(4) { Array.new(4, 0) }
      if layout
        load_layout(layout)
      else
        2.times { generate }
      end
    end

    def right!
      @layout.each_with_index do |each, index|
        @layout[index] = Numbers.new(each).right
      end
    end

    def left!
      @layout.each_with_index do |each, index|
        @layout[index] = Numbers.new(each).left
      end
    end

    def up!
      @layout.transpose.each_with_index do |each, index|
        column = Numbers.new(each).left
        0.upto(3).each { |y| @layout[y][index] = column[y] }
      end
    end

    def down!
      @layout.transpose.each_with_index do |each, index|
        column = Numbers.new(each).right
        0.upto(3).each { |y| @layout[y][index] = column[y] }
      end
    end

    def to_s
      @layout.map do |row|
        row.map do |number|
          number != 0 ? number : '_'
        end.join(' ')
      end.join("\n")
    end

    def generate
      loop do
        x = rand(4)
        y = rand(4)
        if @layout[y][x] == 0
          @layout[y][x] = (rand < 0.8 ? 2 : 4)
          return
        end
      end
    end

    private

    def load_layout(layout)
      layout.each_with_index do |row, y|
        row.each_with_index do |number, x|
          @layout[y][x] = number
        end
      end
    end
  end
end
