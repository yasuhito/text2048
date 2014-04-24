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
        board.to_s == (<<-BOARD).chomp
____
____
____
____
BOARD
      end
    end
  end

  context 'with one 2' do
    Given(:board) do
      Text2048::Board.new([[2, 0, 0, 0],
                           [0, 0, 0, 0],
                           [0, 0, 0, 0],
                           [0, 0, 0, 0]])
    end

    describe '#right' do
      When { board.right! }

      Then do
        board.to_s == (<<-BOARD).chomp
___2
____
____
____
BOARD
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
        board.to_s == (<<-BOARD).chomp
___2
___2
___2
___2
BOARD
      end
    end
  end

  context 'with two "2"s that can be merged' do
    Given(:board) do
      Text2048::Board.new([[2, 2, 0, 0],
                           [0, 0, 0, 0],
                           [0, 0, 0, 0],
                           [0, 0, 0, 0]])
    end

    describe '#right' do
      When { board.right! }

      Then do
        board.to_s == (<<-BOARD).chomp
___4
____
____
____
BOARD
      end
    end
  end

  context 'with four 2s in a row' do
    Given(:board) do
      Text2048::Board.new([[2, 2, 2, 2],
                           [0, 0, 0, 0],
                           [0, 0, 0, 0],
                           [0, 0, 0, 0]])
    end

    describe '#right' do
      When { board.right! }

      Then do
        board.to_s == (<<-BOARD).chomp
__44
____
____
____
BOARD
      end
    end
  end

  context 'with six "2"s that can be merged' do
    Given(:board) do
      Text2048::Board.new([[2, 2, 0, 0],
                           [0, 2, 0, 0],
                           [0, 0, 2, 2],
                           [0, 0, 0, 2]])
    end

    describe '#right' do
      When { board.right! }

      Then do
        board.to_s == (<<-BOARD).chomp
___4
___2
___4
___2
BOARD
      end
    end
  end
end
