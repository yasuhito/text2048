require 'game2048/board'

module Game2048
  class Game
    def initialize
      @board = Board.new
    end

    def start
      puts @board.to_s
    end
  end
end
