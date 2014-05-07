# encoding: utf-8

require 'text2048'

describe Text2048::Board, '.new' do
  context 'with all zeroes' do
    Given(:board) do
      Text2048::Board.new([[nil, nil, nil, nil],
                           [nil, nil, nil, nil],
                           [nil, nil, nil, nil],
                           [nil, nil, nil, nil]])
    end

    describe '#to_a' do
      When(:result) { board.to_a }

      Then do
        result == [[nil, nil, nil, nil],
                   [nil, nil, nil, nil],
                   [nil, nil, nil, nil],
                   [nil, nil, nil, nil]]
      end
    end

    describe '#right' do
      When(:result) { board.right }

      Then do
        result.to_a == [[nil, nil, nil, nil],
                        [nil, nil, nil, nil],
                        [nil, nil, nil, nil],
                        [nil, nil, nil, nil]]
      end
    end
  end

  context 'with four 2s' do
    Given(:board) do
      Text2048::Board.new([[2, nil, nil, nil],
                           [nil, 2, nil, nil],
                           [nil, nil, 2, nil],
                           [nil, nil, nil, 2]])
    end

    describe '#right' do
      When(:result) { board.right }

      Then do
        result.to_a == [[nil, nil, nil, 2],
                        [nil, nil, nil, 2],
                        [nil, nil, nil, 2],
                        [nil, nil, nil, 2]]
      end
    end
  end

  context 'with six 2s that can be merged' do
    Given(:board) do
      Text2048::Board.new([[2, nil, 2, nil],
                           [nil, 2, nil, nil],
                           [nil, 2, nil, 2],
                           [nil, nil, nil, 2]])
    end

    describe '#right' do
      When(:result) { board.right }

      Then do
        result.to_a == [[nil, nil, nil, 4],
                        [nil, nil, nil, 2],
                        [nil, nil, nil, 4],
                        [nil, nil, nil, 2]]
      end
    end
  end
end
