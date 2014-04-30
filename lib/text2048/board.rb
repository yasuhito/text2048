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

    def initialize_copy(board)
      @layout = board.layout.dup
    end

    def right!
      move! :right
    end

    def left!
      move! :left
    end

    def up!
      transpose { move! :left }
    end

    def down!
      transpose { move! :right }
    end

    def ==(other)
      @layout.zip(other.layout).reduce(true) do |result, each|
        result && Numbers.new(each[0]) == Numbers.new(each[1])
      end
    end

    def generate
      loop do
        x = rand(4)
        y = rand(4)
        if @layout[y][x] == 0
          @layout[y][x] = (rand < 0.8 ? 2 : 4)
          return [y, x, @layout[y][x]]
        end
      end
    end

    private

    def move!(direction)
      score = 0
      @layout.map! do |each|
        row, sc = Numbers.new(each).__send__ direction
        score += sc
        row
      end
      score
    end

    def transpose
      @layout = @layout.transpose
      score = yield
      @layout = @layout.transpose
      score
    end

    def load_layout(layout)
      layout.each_with_index do |row, y|
        row.each_with_index do |number, x|
          @layout[y][x] = number
        end
      end
    end
  end
end
