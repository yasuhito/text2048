# encoding: utf-8

require 'text2048'

describe Text2048::Game, '.new' do
  context 'with empty board' do
    Given(:board) do
      Text2048::Board.new([[0, 0, 0, 0],
                           [0, 0, 0, 0],
                           [0, 0, 0, 0],
                           [0, 0, 0, 0]])
    end
    Given(:game) { Text2048::Game.new(board) }

    describe '#left' do
      When(:result) { game.left }
      Then do
        result.layout == [[0, 0, 0, 0],
                          [0, 0, 0, 0],
                          [0, 0, 0, 0],
                          [0, 0, 0, 0]]
      end
    end

    describe '#right' do
      When(:result) { game.right }
      Then do
        result.layout == [[0, 0, 0, 0],
                          [0, 0, 0, 0],
                          [0, 0, 0, 0],
                          [0, 0, 0, 0]]
      end
    end

    describe '#up' do
      When(:result) { game.up }
      Then do
        result.layout == [[0, 0, 0, 0],
                          [0, 0, 0, 0],
                          [0, 0, 0, 0],
                          [0, 0, 0, 0]]
      end
    end

    describe '#down' do
      When(:result) { game.down }
      Then do
        result.layout == [[0, 0, 0, 0],
                          [0, 0, 0, 0],
                          [0, 0, 0, 0],
                          [0, 0, 0, 0]]
      end
    end

    describe '#score' do
      Then { game.score == 0 }
    end
  end
end
