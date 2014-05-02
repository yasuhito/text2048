require 'text2048'

describe Text2048::Board, '.new' do
  context 'with no numbers' do
    Given(:board) do
      Text2048::Board.new([[0, 0, 0, 0],
                           [0, 0, 0, 0],
                           [0, 0, 0, 0],
                           [0, 0, 0, 0]])
    end

    describe '#right' do
      When { board.right! }

      Then do
        board.layout == [[0, 0, 0, 0],
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
      When { board.right! }

      Then do
        board.layout == [[0, 0, 0, 2],
                         [0, 0, 0, 2],
                         [0, 0, 0, 2],
                         [0, 0, 0, 2]]
      end
    end

    describe '#==' do
      When(:result) do
        board == Text2048::Board.new([[0, 0, 0, 2],
                                      [0, 0, 2, 0],
                                      [0, 2, 0, 0],
                                      [2, 0, 0, 0]])
      end

      Then { result == true }
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
      When { board.right! }

      Then do
        board.layout == [[0, 0, 0, 4],
                         [0, 0, 0, 2],
                         [0, 0, 0, 4],
                         [0, 0, 0, 2]]
      end
    end
  end
end
