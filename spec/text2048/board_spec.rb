# encoding: utf-8

require 'text2048'

describe Text2048::Board, '.new' do
  context 'without arguments' do
    Given(:board) { Text2048::Board.new }

    Then { board.generated_tiles.empty? }
    And { board.merged_tiles.empty? }
    And { board.score == 0 }
  end

  context 'with one 2048 tile' do
    Given(:board) do
      Text2048::Board.new([[nil, nil,  nil, nil],
                           [nil, nil,  nil, nil],
                           [nil, 2048, nil, nil],
                           [nil, nil,  nil, nil]])
    end

    Then { board.win? }
  end

  context 'with tiles which cannot be merged' do
    Given(:board) do
      Text2048::Board.new([[2,   4,  8,  16],
                           [4,   8, 16,  32],
                           [8,  16, 32,  64],
                           [16, 32, 64, 128]])
    end

    Then { board.lose? }
  end

  context 'with all nils' do
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
      And { result.score == 0 }
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
      And { result.score == 0 }
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
      And { result.score == 8 }
    end
  end
end
