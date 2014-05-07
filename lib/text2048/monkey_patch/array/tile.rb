# encoding: utf-8

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  module MonkeyPatch
    module Array
      # 2048 related methods
      module Tile
        def rmerge
          score = 0
          tiles = dup
          (size - 1).downto(1) do |each|
            if tiles[each - 1] && tiles[each - 1] == tiles[each]
              tiles[each] = Text2048::Tile.new(tiles[each].to_i * 2, :merged)
              tiles[each - 1] = nil
              score += tiles[each].to_i
            end
          end
          [tiles, score]
        end

        def rshrink
          orig_size = size
          tiles = compact
          ::Array.new(orig_size - tiles.size) + tiles
        end
      end
    end
  end
end
