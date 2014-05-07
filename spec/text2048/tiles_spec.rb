# encoding: utf-8

require 'text2048'

describe Text2048::Tiles, '.new' do
  context 'with [nil, nil, nil, nil]' do
    Given(:tiles) { Text2048::Tiles.new([nil, nil, nil, nil]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result.to_a == [nil, nil, nil, nil] }
      And { result.score == 0 }
    end

    describe '#left' do
      When(:result) { tiles.left }

      Then { result.to_a == [nil, nil, nil, nil] }
      And { result.score == 0 }
    end
  end

  context 'with [2, nil, nil, nil]' do
    Given(:tiles) { Text2048::Tiles.new([2, nil, nil, nil]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result.to_a == [nil, nil, nil, 2] }
      And { result.score == 0 }
    end

    describe '#left' do
      When(:result) { tiles.left }

      Then { result.to_a == [2, nil, nil, nil] }
      And { result.score == 0 }
    end
  end

  context 'with [nil, 2, nil, nil]' do
    Given(:tiles) { Text2048::Tiles.new([nil, 2, nil, nil]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result.to_a == [nil, nil, nil, 2] }
      And { result.score == 0 }
    end

    describe '#left' do
      When(:result) { tiles.left }

      Then { result.to_a == [2, nil, nil, nil] }
      And { result.score == 0 }
    end
  end

  context 'with [nil, nil, 2, nil]' do
    Given(:tiles) { Text2048::Tiles.new([nil, nil, 2, nil]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result.to_a == [nil, nil, nil, 2] }
      And { result.score == 0 }
    end

    describe '#left' do
      When(:result) { tiles.left }

      Then { result.to_a == [2, nil, nil, nil] }
      And { result.score == 0 }
    end
  end

  context 'with [nil, nil, nil, 2]' do
    Given(:tiles) { Text2048::Tiles.new([nil, nil, nil, 2]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result.to_a == [nil, nil, nil, 2] }
      And { result.score == 0 }
    end

    describe '#left' do
      When(:result) { tiles.left }

      Then { result.to_a == [2, nil, nil, nil] }
      And { result.score == 0 }
    end
  end

  context 'with [2, 2, nil, nil]' do
    Given(:tiles) { Text2048::Tiles.new([2, 2, nil, nil]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result.to_a == [nil, nil, nil, 4] }
      And { result.score == 4 }
    end

    describe '#left' do
      When(:result) { tiles.left }

      Then { result.to_a == [4, nil, nil, nil] }
      And { result.score == 4 }
    end
  end

  context 'with [2, 2, 2, nil]' do
    Given(:tiles) { Text2048::Tiles.new([2, 2, 2, nil]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result.to_a == [nil, nil, 2, 4] }
      And { result[3].merged? }
      And { result.score == 4 }
    end

    describe '#left' do
      When(:result) { tiles.left }

      Then { result.to_a == [4, 2, nil, nil] }
      And { result[0].merged? }
      And { result.score == 4 }
    end
  end

  context 'with [2, 2, 2, 2]' do
    Given(:tiles) { Text2048::Tiles.new([2, 2, 2, 2]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result.to_a == [nil, nil, 4, 4] }
      And { result[2].merged? }
      And { result[3].merged? }
      And { result.score == 8 }
    end

    describe '#left' do
      When(:result) { tiles.left }

      Then { result.to_a == [4, 4, nil, nil] }
      And { result[0].merged? }
      And { result[1].merged? }
      And { result.score == 8 }
    end
  end

  context 'with [4, 4, 2, 2]' do
    Given(:tiles) { Text2048::Tiles.new([4, 4, 2, 2]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result.to_a == [nil, nil, 8, 4] }
      And { result[2].merged? }
      And { result[3].merged? }
      And { result.score == 12 }
    end

    describe '#left' do
      When(:result) { tiles.left }

      Then { result.to_a == [8, 4, nil, nil] }
      And { result[0].merged? }
      And { result[1].merged? }
      And { result.score == 12 }
    end
  end

  context 'with [nil, 4, nil, 2]' do
    Given(:tiles) { Text2048::Tiles.new([nil, 4, nil, 2]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result.to_a == [nil, nil, 4, 2] }
      And { result.score == 0 }
    end

    describe '#left' do
      When(:result) { tiles.left }

      Then { result.to_a == [4, 2, nil, nil] }
      And { result.score == 0 }
    end
  end

  context 'with [16, 8, 4, 2]' do
    Given(:tiles) { Text2048::Tiles.new([16, 8, 4, 2]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result.to_a == [16, 8, 4, 2] }
      And { result.score == 0 }
    end

    describe '#left' do
      When(:result) { tiles.left }

      Then { result.to_a == [16, 8, 4, 2] }
      And { result.score == 0 }
    end
  end
end
