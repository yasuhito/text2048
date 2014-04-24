require 'text2048/board'

module Text2048
  class Game
    def initialize
      @board = Board.new
    end

    def start
      puts @board.to_s
    end
  end
end
