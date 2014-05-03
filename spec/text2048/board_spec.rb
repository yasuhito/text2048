# encoding: utf-8

require 'text2048'

describe Text2048::Board, '.new' do
  context 'with all zeroes' do
    Given(:board) do
      Text2048::Board.new([[0, 0, 0, 0],
                           [0, 0, 0, 0],
                           [0, 0, 0, 0],
                           [0, 0, 0, 0]])
    end

    describe '#right' do
      When(:result) { board.right }

      Then do
        result.layout == [[0, 0, 0, 0],
                          [0, 0, 0, 0],
                          [0, 0, 0, 0],
                          [0, 0, 0, 0]]
      end
    end
  end

  context 'with four 2s' do
    Given(:board) do
      Text2048::Board.new([[2, 0, 0, 0],
                           [0, 2, 0, 0],
                           [0, 0, 2, 0],
                           [0, 0, 0, 2]])
    end

    describe '#right' do
      When(:result) { board.right }

      Then do
        result.layout == [[0, 0, 0, 2],
                          [0, 0, 0, 2],
                          [0, 0, 0, 2],
                          [0, 0, 0, 2]]
      end
    end
  end

  context 'with six 2s that can be merged' do
    Given(:board) do
      Text2048::Board.new([[2, 0, 2, 0],
                           [0, 2, 0, 0],
                           [0, 2, 0, 2],
                           [0, 0, 0, 2]])
    end

    describe '#right' do
      When(:result) { board.right }

      Then do
        result.layout == [[0, 0, 0, 4],
                          [0, 0, 0, 2],
                          [0, 0, 0, 4],
                          [0, 0, 0, 2]]
      end
    end
  end
end
