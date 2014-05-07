# encoding: utf-8

require 'text2048'

describe Text2048::Tiles, '.new' do
  context 'with [nil, nil, nil, nil]' do
    Given(:tiles) { Text2048::Tiles.new([nil, nil, nil, nil]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result[0] == [nil, nil, nil, nil] }
    end
  end

  context 'with [2, nil, nil, nil]' do
    Given(:tiles) { Text2048::Tiles.new([2, nil, nil, nil]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result[0] == [nil, nil, nil, 2] }
    end
  end

  context 'with [nil, 2, nil, nil]' do
    Given(:tiles) { Text2048::Tiles.new([nil, 2, nil, nil]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result[0] == [nil, nil, nil, 2] }
    end
  end

  context 'with [nil, nil, 2, nil]' do
    Given(:tiles) { Text2048::Tiles.new([nil, nil, 2, nil]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result[0] == [nil, nil, nil, 2] }
    end
  end

  context 'with [nil, nil, nil, 2]' do
    Given(:tiles) { Text2048::Tiles.new([nil, nil, nil, 2]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result[0] == [nil, nil, nil, 2] }
    end
  end

  context 'with [2, 2, nil, nil]' do
    Given(:tiles) { Text2048::Tiles.new([2, 2, nil, nil]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result[0] == [nil, nil, nil, 4] }
    end
  end

  context 'with [2, 2, 2, nil]' do
    Given(:tiles) { Text2048::Tiles.new([2, 2, 2, nil]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result[0] == [nil, nil, 2, 4] }
    end
  end

  context 'with [2, 2, 2, 2]' do
    Given(:tiles) { Text2048::Tiles.new([2, 2, 2, 2]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result[0] == [nil, nil, 4, 4] }
    end
  end

  context 'with [4, 4, 2, 2]' do
    Given(:tiles) { Text2048::Tiles.new([4, 4, 2, 2]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result[0] == [nil, nil, 8, 4] }
    end
  end

  context 'with [nil, 4, nil, 2]' do
    Given(:tiles) { Text2048::Tiles.new([nil, 4, nil, 2]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result[0] == [nil, nil, 4, 2] }
    end
  end

  context 'with [16, 8, 4, 2]' do
    Given(:tiles) { Text2048::Tiles.new([16, 8, 4, 2]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result[0] == [16, 8, 4, 2] }
    end
  end
end
