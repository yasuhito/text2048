# encoding: utf-8

require 'text2048'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # Controller class.
  class App
    HIGH_SCORE_FILE = File.expand_path('~/.text2048')

    attr_reader :board
    attr_reader :view

    def initialize(view = CursesView.new, board = Board.new)
      @view = view
      @board = board
      @high_score = if FileTest.exists?(HIGH_SCORE_FILE)
                      IO.read(HIGH_SCORE_FILE).to_i
                    else
                      0
                    end
    end

    def update_high_score
      File.open(HIGH_SCORE_FILE, 'w') { |file| file.print @high_score }
      @view.high_score(@high_score)
    end

    def generate(num_tiles = 1)
      num_tiles.times { @board = @board.generate }
      @view.update(@board)
      @view.zoom_tiles(@board.generated_tiles)
    end

    def step
      @view.win if @board.win?
      @view.game_over if @board.lose?
      input @view.command
      update_high_score
    end

    private

    def input(command)
      case command
      when :larger, :smaller
        @view.__send__ command, @board
      when :left, :right, :up, :down
        move_and_generate(command)
      when :quit
        exit 0
      end
    end

    def move_and_generate(command)
      last = move(command)
      generate if @board.generate?(last)
      score = @board.score
      @high_score = score if score > @high_score
    end

    def move(command)
      last = @board
      @board = @board.__send__(command)
      @view.update(@board)
      @view.pop_tiles(@board.merged_tiles)
      last
    end
  end
end
