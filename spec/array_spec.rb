# encoding: utf-8

require 'text2048'

describe Array do
  def tiles_with(contents)
    contents.map { |each| Text2048::Tile.new(each) }
  end

  context '[0, 0, 0, 0]' do
    Given(:tiles) { tiles_with([0, 0, 0, 0]) }

    describe '#right' do
      When(:score) { tiles.right[1] }

      Then { tiles == [0, 0, 0, 0] }
      And { score == 0 }
      And { !tiles[0].merged? }
      And { !tiles[1].merged? }
      And { !tiles[2].merged? }
      And { !tiles[3].merged? }
    end
  end

  context '[2, 0, 0, 0]' do
    Given(:tiles) { tiles_with([2, 0, 0, 0]) }

    describe '#right' do
      When(:score) { tiles.right[1] }

      Then { tiles == [0, 0, 0, 2] }
      And { score == 0 }
      And { !tiles[0].merged? }
      And { !tiles[1].merged? }
      And { !tiles[2].merged? }
      And { !tiles[3].merged? }
    end
  end

  context '[0, 2, 0, 0]' do
    Given(:tiles) { tiles_with([0, 2, 0, 0]) }

    describe '#right' do
      When(:score) { tiles.right[1] }

      Then { tiles == [0, 0, 0, 2] }
      And { score == 0 }
      And { !tiles[0].merged? }
      And { !tiles[1].merged? }
      And { !tiles[2].merged? }
      And { !tiles[3].merged? }
    end
  end

  context '[0, 0, 2, 0]' do
    Given(:tiles) { tiles_with([0, 0, 2, 0]) }

    describe '#right' do
      When(:score) { tiles.right[1] }

      Then { tiles == [0, 0, 0, 2] }
      And { score == 0 }
      And { !tiles[0].merged? }
      And { !tiles[1].merged? }
      And { !tiles[2].merged? }
      And { !tiles[3].merged? }
    end
  end

  context '[0, 0, 0, 2]' do
    Given(:tiles) { tiles_with([0, 0, 0, 2]) }

    describe '#right' do
      When(:score) { tiles.right[1] }

      Then { tiles == [0, 0, 0, 2] }
      And { score == 0 }
      And { !tiles[0].merged? }
      And { !tiles[1].merged? }
      And { !tiles[2].merged? }
      And { !tiles[3].merged? }
    end
  end

  context '[0, 2, 0, 2]' do
    Given(:tiles) { tiles_with([0, 2, 0, 2]) }

    describe '#right' do
      When(:score) { tiles.right[1] }

      Then { tiles == [0, 0, 0, 4] }
      And { score == 4 }
      And { !tiles[0].merged? }
      And { !tiles[1].merged? }
      And { !tiles[2].merged? }
      And { tiles[3].merged? }
    end
  end

  context '[2, 2, 0, 0]' do
    Given(:tiles) { tiles_with([2, 2, 0, 0]) }

    describe '#right' do
      When(:score) { tiles.right[1] }

      Then { tiles == [0, 0, 0, 4] }
      And { score == 4 }
      And { !tiles[0].merged? }
      And { !tiles[1].merged? }
      And { !tiles[2].merged? }
      And { tiles[3].merged? }
    end
  end

  context '[2, 2, 2, 0]' do
    Given(:tiles) { tiles_with([2, 2, 2, 0]) }

    describe '#right' do
      When(:score) { tiles.right[1] }

      Then { tiles == [0, 0, 2, 4] }
      And { score == 4 }
      And { !tiles[0].merged? }
      And { !tiles[1].merged? }
      And { !tiles[2].merged? }
      And { tiles[3].merged? }
    end
  end

  context '[2, 2, 2, 2]' do
    Given(:tiles) { tiles_with([2, 2, 2, 2]) }

    describe '#right' do
      When(:score) { tiles.right[1] }

      Then { tiles == [0, 0, 4, 4] }
      And { score == 8 }
      And { !tiles[0].merged? }
      And { !tiles[1].merged? }
      And { tiles[2].merged? }
      And { tiles[3].merged? }
    end
  end

  context '[4, 4, 2, 2]' do
    Given(:tiles) { tiles_with([4, 4, 2, 2]) }

    describe '#right' do
      When(:score) { tiles.right[1] }

      Then { tiles == [0, 0, 8, 4] }
      And { score == 12 }
      And { !tiles[0].merged? }
      And { !tiles[1].merged? }
      And { tiles[2].merged? }
      And { tiles[3].merged? }
    end
  end

  context '[0, 4, 0, 2]' do
    Given(:tiles) { tiles_with([0, 4, 0, 2]) }

    describe '#right' do
      When(:score) { tiles.right[1] }

      Then { tiles == [0, 0, 4, 2] }
      And { score == 0 }
      And { !tiles[0].merged? }
      And { !tiles[1].merged? }
      And { !tiles[2].merged? }
      And { !tiles[3].merged? }
    end
  end

  context 'with [16, 8, 4, 2]' do
    Given(:tiles) { tiles_with([16, 8, 4, 2]) }

    describe '#right' do
      When(:score) { tiles.right[1] }

      Then { tiles == [16, 8, 4, 2] }
      And { score == 0 }
      And { !tiles[0].merged? }
      And { !tiles[1].merged? }
      And { !tiles[2].merged? }
      And { !tiles[3].merged? }
    end
  end
end
