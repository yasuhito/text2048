# encoding: utf-8

module Text2048
  module MonkeyPatch
    module Array
      # 2048 related methods
      module Tile
        def rmerge
          score = 0
          tiles = dup
          (size - 1).downto(1) do |each|
            if tiles[each - 1] == tiles[each]
              tiles[each] = Text2048::Tile.new(tiles[each].to_i * 2, :merged)
              tiles[each - 1] = Text2048::Tile.new(0)
              score += tiles[each].to_i
            end
          end
          [tiles, score]
        end

        def rshrink
          tiles = dup
          orig_size = tiles.size
          tiles.select! { |each| each != 0 }
          ::Array.new(orig_size - tiles.size) { Text2048::Tile.new(0) } + tiles
        end
      end
    end
  end
end
