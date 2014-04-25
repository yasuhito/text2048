require 'text2048/board'

module Text2048
  # A class responsible of handling all the command line interface
  # logic.
  class Game
    KEYS = { 'h' => :left!, 'l' => :right!, 'k' => :up!, 'j' => :down! }

    def initialize(output = STDOUT)
      @board = Board.new
      @output = output
    end

    def start
      @output.puts @board.to_s
    end

    def input(input)
      method = KEYS[input]
      if method
        @board.__send__ method
      else
        fail 'Invalid command.'
      end
      @board.generate
      @output.puts @board.to_s
    end
  end
end
