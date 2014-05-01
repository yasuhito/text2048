# encoding: utf-8

require 'text2048'

describe Text2048::Tiles, '.new' do
  context 'with [0, 0, 0, 0]' do
    Given(:tiles) { Text2048::Tiles.new([0, 0, 0, 0]) }

    describe '#right' do
      When(:result) { tiles.right }

      Then { result[0] == [0, 0, 0, 0] }
    end
  end

  # context 'with [2, 0, 0, 0]' do
  #   Given(:tiles) { Text2048::Tiles.new([2, 0, 0, 0]) }

  #   describe '#right' do
  #     When(:result) { tiles.right }

  #     Then { result[0] == [0, 0, 0, 2] }
  #   end
  # end

  # context 'with [0, 2, 0, 0]' do
  #   Given(:tiles) { Text2048::Tiles.new([0, 2, 0, 0]) }

  #   describe '#right' do
  #     When(:result) { tiles.right }

  #     Then { result[0] == [0, 0, 0, 2] }
  #   end
  # end

  # context 'with [0, 0, 2, 0]' do
  #   Given(:tiles) { Text2048::Tiles.new([0, 0, 2, 0]) }

  #   describe '#right' do
  #     When(:result) { tiles.right }

  #     Then { result[0] == [0, 0, 0, 2] }
  #   end
  # end

  # context 'with [0, 0, 0, 2]' do
  #   Given(:tiles) { Text2048::Tiles.new([0, 0, 0, 2]) }

  #   describe '#right' do
  #     When(:result) { tiles.right }

  #     Then { result[0] == [0, 0, 0, 2] }
  #   end
  # end

  # context 'with [2, 2, 0, 0]' do
  #   Given(:tiles) { Text2048::Tiles.new([2, 2, 0, 0]) }

  #   describe '#right' do
  #     When(:result) { tiles.right }

  #     Then { result[0] == [0, 0, 0, 4] }
  #   end
  # end

  # context 'with [2, 2, 2, 0]' do
  #   Given(:tiles) { Text2048::Tiles.new([2, 2, 2, 0]) }

  #   describe '#right' do
  #     When(:result) { tiles.right }

  #     Then { result[0] == [0, 0, 2, 4] }
  #   end
  # end

  # context 'with [2, 2, 2, 2]' do
  #   Given(:tiles) { Text2048::Tiles.new([2, 2, 2, 2]) }

  #   describe '#right' do
  #     When(:result) { tiles.right }

  #     Then { result[0] == [0, 0, 4, 4] }
  #   end
  # end

  # context 'with [4, 4, 2, 2]' do
  #   Given(:tiles) { Text2048::Tiles.new([4, 4, 2, 2]) }

  #   describe '#right' do
  #     When(:result) { tiles.right }

  #     Then { result[0] == [0, 0, 8, 4] }
  #   end
  # end

  # context 'with [0, 4, 0, 2]' do
  #   Given(:tiles) { Text2048::Tiles.new([0, 4, 0, 2]) }

  #   describe '#right' do
  #     When(:result) { tiles.right }

  #     Then { result[0] == [0, 0, 4, 2] }
  #   end
  # end

  # context 'with [16, 8, 4, 2]' do
  #   Given(:tiles) { Text2048::Tiles.new([16, 8, 4, 2]) }

  #   describe '#right' do
  #     When(:result) { tiles.right }

  #     Then { result[0] == [16, 8, 4, 2] }
  #   end
  # end
end
