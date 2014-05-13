# encoding: utf-8

require 'text2048'

describe Text2048::Board do
  Given(:board) do
    initial_tiles ? Text2048::Board.new(initial_tiles) : Text2048::Board.new
  end
  Invariant { board.score == 0 }
  Invariant { board.generated_tiles.empty? }
  Invariant { board.merged_tiles.empty? }

  context 'with no arguments' do
    Given(:initial_tiles) {}

    describe '#tiles' do
      When(:tiles) { board.tiles }
      Then { tiles.empty? }
    end

    describe '#generate' do
      When(:new_board) { board.generate }
      Then { new_board.generated_tiles.size == 1 }
    end

    describe '#generate?' do
      context 'with empty board' do
        Given(:other) { Text2048::Board.new }
        When(:result) { board.generate?(other) }
        Then { result == false }
      end
    end

    describe '#win?' do
      When(:result) { board.win? }
      Then { result == false }
    end

    describe '#lose?' do
      When(:result) { board.lose? }
      Then { result == false }
    end

    describe '#right' do
      When(:result) { board.right }

      Then do
        result.to_a == [[0, 0, 0, 0],
                        [0, 0, 0, 0],
                        [0, 0, 0, 0],
                        [0, 0, 0, 0]]
      end
      And { result.score == 0 }
    end

    describe '#left' do
      When(:result) { board.left }

      Then do
        result.to_a == [[0, 0, 0, 0],
                        [0, 0, 0, 0],
                        [0, 0, 0, 0],
                        [0, 0, 0, 0]]
      end
      And { result.score == 0 }
    end

    describe '#up' do
      When(:result) { board.up }

      Then do
        result.to_a == [[0, 0, 0, 0],
                        [0, 0, 0, 0],
                        [0, 0, 0, 0],
                        [0, 0, 0, 0]]
      end
      And { result.score == 0 }
    end

    describe '#down' do
      When(:result) { board.down }

      Then do
        result.to_a == [[0, 0, 0, 0],
                        [0, 0, 0, 0],
                        [0, 0, 0, 0],
                        [0, 0, 0, 0]]
      end
      And { result.score == 0 }
    end

    describe '#to_a' do
      When(:result) { board.to_a }
      Then do
        result == [[0, 0, 0, 0],
                   [0, 0, 0, 0],
                   [0, 0, 0, 0],
                   [0, 0, 0, 0]]
      end
    end
  end

  context 'with four 2s in diagonal' do
    Given(:initial_tiles) do
      [[2, 0, 0, 0],
       [0, 2, 0, 0],
       [0, 0, 2, 0],
       [0, 0, 0, 2]]
    end

    describe '#tiles' do
      When(:tiles) { board.tiles }
      Then { board.tiles.size == 4 }
      And { board.tiles[[0, 0]] == 2 }
      And { board.tiles[[1, 1]] == 2 }
      And { board.tiles[[2, 2]] == 2 }
      And { board.tiles[[3, 3]] == 2 }
    end

    describe '#generate' do
      When(:new_board) { board.generate }
      Then { new_board.generated_tiles.size == 1 }
    end

    describe '#generate?' do
      context 'with empty board' do
        Given(:other) { Text2048::Board.new }
        When(:result) { board.generate?(other) }
        Then { result == true }
      end
    end

    describe '#win?' do
      When(:result) { board.win? }
      Then { result == false }
    end

    describe '#lose?' do
      When(:result) { board.lose? }
      Then { result == false }
    end

    describe '#right' do
      When(:result) { board.right }

      Then do
        result.to_a == [[0, 0, 0, 2],
                        [0, 0, 0, 2],
                        [0, 0, 0, 2],
                        [0, 0, 0, 2]]
      end
      And { result.merged_tiles.empty? }
      And { result.score == 0 }
    end

    describe '#left' do
      When(:result) { board.left }

      Then do
        result.to_a == [[2, 0, 0, 0],
                        [2, 0, 0, 0],
                        [2, 0, 0, 0],
                        [2, 0, 0, 0]]
      end
      And { result.merged_tiles.empty? }
      And { result.score == 0 }
    end

    describe '#up' do
      When(:result) { board.up }

      Then do
        result.to_a == [[2, 2, 2, 2],
                        [0, 0, 0, 0],
                        [0, 0, 0, 0],
                        [0, 0, 0, 0]]
      end
      And { result.merged_tiles.empty? }
      And { result.score == 0 }
    end

    describe '#down' do
      When(:result) { board.down }

      Then do
        result.to_a == [[0, 0, 0, 0],
                        [0, 0, 0, 0],
                        [0, 0, 0, 0],
                        [2, 2, 2, 2]]
      end
      And { result.merged_tiles.empty? }
      And { result.score == 0 }
    end

    describe '#to_a' do
      When(:result) { board.to_a }
      Then do
        result == [[2, 0, 0, 0],
                   [0, 2, 0, 0],
                   [0, 0, 2, 0],
                   [0, 0, 0, 2]]
      end
    end
  end

  context 'with six 2s that can be merged' do
    Given(:initial_tiles) do
      [[2, 0, 2, 0],
       [0, 2, 0, 0],
       [0, 2, 0, 2],
       [0, 0, 0, 2]]
    end

    describe '#tiles' do
      When(:tiles) { board.tiles }
      Then { board.tiles.size == 6 }
      And { board.tiles[[0, 0]] == 2 }
      And { board.tiles[[0, 2]] == 2 }
      And { board.tiles[[1, 1]] == 2 }
      And { board.tiles[[2, 1]] == 2 }
      And { board.tiles[[2, 3]] == 2 }
      And { board.tiles[[3, 3]] == 2 }
    end

    describe '#generate' do
      When(:new_board) { board.generate }
      Then { new_board.generated_tiles.size == 1 }
    end

    describe '#generate?' do
      context 'with empty board' do
        Given(:other) { Text2048::Board.new }
        When(:result) { board.generate?(other) }
        Then { result == true }
      end
    end

    describe '#win?' do
      When(:result) { board.win? }
      Then { result == false }
    end

    describe '#lose?' do
      When(:result) { board.lose? }
      Then { result == false }
    end

    describe '#right' do
      When(:result) { board.right }

      Then do
        result.to_a == [[0, 0, 0, 4],
                        [0, 0, 0, 2],
                        [0, 0, 0, 4],
                        [0, 0, 0, 2]]
      end
      And { result.to_a[0][3].merged? }
      And { result.to_a[2][3].merged? }
      And { result.merged_tiles == [[0, 3], [2, 3]] }
      And { result.score == 8 }
    end

    describe '#left' do
      When(:result) { board.left }

      Then do
        result.to_a == [[4, 0, 0, 0],
                        [2, 0, 0, 0],
                        [4, 0, 0, 0],
                        [2, 0, 0, 0]]
      end
      And { result.to_a[0][0].merged? }
      And { result.to_a[2][0].merged? }
      And { result.merged_tiles == [[0, 0], [2, 0]] }
      And { result.score == 8 }
    end

    describe '#up' do
      When(:result) { board.up }

      Then do
        result.to_a == [[2, 4, 2, 4],
                        [0, 0, 0, 0],
                        [0, 0, 0, 0],
                        [0, 0, 0, 0]]
      end
      And { result.to_a[0][1].merged? }
      And { result.to_a[0][3].merged? }
      And { result.merged_tiles == [[0, 1], [0, 3]] }
      And { result.score == 8 }
    end

    describe '#down' do
      When(:result) { board.down }

      Then do
        result.to_a == [[0, 0, 0, 0],
                        [0, 0, 0, 0],
                        [0, 0, 0, 0],
                        [2, 4, 2, 4]]
      end
      And { result.to_a[3][1].merged? }
      And { result.to_a[3][3].merged? }
      And { result.merged_tiles == [[3, 1], [3, 3]] }
      And { result.score == 8 }
    end

    describe '#to_a' do
      When(:result) { board.to_a }
      Then do
        result == [[2, 0, 2, 0],
                   [0, 2, 0, 0],
                   [0, 2, 0, 2],
                   [0, 0, 0, 2]]
      end
    end
  end

  context 'with one 2048 tile' do
    Given(:initial_tiles) do
      [[0, 0, 0, 0],
       [0, 0, 0, 0],
       [0, 2048, 0, 0],
       [0, 0, 0, 0]]
    end

    describe '#win?' do
      When(:result) { board.win? }
      Then { result == true }
    end

    describe '#lose?' do
      When(:result) { board.lose? }
      Then { result == false }
    end
  end

  context 'with 16 tiles which cannot be merged' do
    Given(:initial_tiles) do
      [[2, 4, 8, 16],
       [4, 8, 16, 32],
       [8, 16, 32, 64],
       [16, 32, 64, 128]]
    end

    describe '#tiles' do
      When(:result) { board.tiles }
      Then { result.size == 16 }
    end

    describe '#generate' do
      When(:result) { board.generate }
      Then { result == Failure(RuntimeError) }
    end

    describe '#win?' do
      When(:result) { board.win? }
      Then { result == false }
    end

    describe '#lose?' do
      When(:result) { board.lose? }
      Then { result == true }
    end

    describe '#right' do
      When(:result) { board.right }
      Then { result.to_a == board.to_a }
    end

    describe '#left' do
      When(:result) { board.left }
      Then { result.to_a == board.to_a }
    end

    describe '#up' do
      When(:result) { board.up }
      Then { result.to_a == board.to_a }
    end

    describe '#down' do
      When(:result) { board.down }
      Then { result.to_a == board.to_a }
    end

    describe '#to_a' do
      When(:result) { board.to_a }
      Then do
        result == [[2, 4, 8, 16],
                   [4, 8, 16, 32],
                   [8, 16, 32, 64],
                   [16, 32, 64, 128]]
      end
    end
  end
end
