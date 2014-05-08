# encoding: utf-8

require 'text2048'

describe Array do
  def tiles_with(contents)
    contents.map { |each| each && Text2048::Tile.new(each) }
  end

  context '[nil, nil, nil, nil]' do
    Given(:tiles) { tiles_with([nil, nil, nil, nil]) }

    describe '#rmerge' do
      When(:score) { tiles.rmerge[1] }

      Then { tiles == tiles_with([nil, nil, nil, nil]) }
      And { score == 0 }
    end
  end

  context '[2, nil, nil, nil]' do
    Given(:tiles) { tiles_with([2, nil, nil, nil]) }

    describe '#rmerge' do
      When(:score) { tiles.rmerge[1] }

      Then { tiles == tiles_with([nil, nil, nil, 2]) }
      And { score == 0 }
    end
  end

  context '[nil, 2, nil, nil]' do
    Given(:tiles) { tiles_with([nil, 2, nil, nil]) }

    describe '#rmerge' do
      When(:score) { tiles.rmerge[1] }

      Then { tiles == tiles_with([nil, nil, nil, 2]) }
      And { score == 0 }
    end
  end

  context '[nil, nil, 2, nil]' do
    Given(:tiles) { tiles_with([nil, nil, 2, nil]) }

    describe '#rmerge' do
      When(:score) { tiles.rmerge[1] }

      Then { tiles == tiles_with([nil, nil, nil, 2]) }
      And { score == 0 }
    end
  end

  context '[nil, nil, nil, 2]' do
    Given(:tiles) { tiles_with([nil, nil, nil, 2]) }

    describe '#rmerge' do
      When(:score) { tiles.rmerge[1] }

      Then { tiles == tiles_with([nil, nil, nil, 2]) }
      And { score == 0 }
    end
  end

  context '[2, 2, nil, nil]' do
    Given(:tiles) { tiles_with([2, 2, nil, nil]) }

    describe '#rmerge' do
      When(:score) { tiles.rmerge[1] }

      Then { tiles == tiles_with([nil, nil, nil, 4]) }
      And { score == 4 }
    end
  end

  context '[2, 2, 2, nil]' do
    Given(:tiles) { tiles_with([2, 2, 2, nil]) }

    describe '#rmerge' do
      When(:score) { tiles.rmerge[1] }

      Then { tiles == tiles_with([nil, nil, 2, 4]) }
      And { tiles[3].merged? }
      And { score == 4 }
    end
  end

  context '[2, 2, 2, 2]' do
    Given(:tiles) { tiles_with([2, 2, 2, 2]) }

    describe '#rmerge' do
      When(:score) { tiles.rmerge[1] }

      Then { tiles == tiles_with([nil, nil, 4, 4]) }
      And { tiles[2].merged? }
      And { tiles[3].merged? }
      And { score == 8 }
    end
  end

  context '[4, 4, 2, 2]' do
    Given(:tiles) { tiles_with([4, 4, 2, 2]) }

    describe '#rmerge' do
      When(:score) { tiles.rmerge[1] }

      Then { tiles == tiles_with([nil, nil, 8, 4]) }
      And { tiles[2].merged? }
      And { tiles[3].merged? }
      And { score == 12 }
    end
  end

  context '[nil, 4, nil, 2]' do
    Given(:tiles) { tiles_with([nil, 4, nil, 2]) }

    describe '#rmerge' do
      When(:score) { tiles.rmerge[1] }

      Then { tiles == tiles_with([nil, nil, 4, 2]) }
      And { score == 0 }
    end
  end

  context 'with [16, 8, 4, 2]' do
    Given(:tiles) { tiles_with([16, 8, 4, 2]) }

    describe '#rmerge' do
      When(:score) { tiles.rmerge[1] }

      Then { tiles == tiles_with([16, 8, 4, 2]) }
      And { score == 0 }
    end
  end
end
