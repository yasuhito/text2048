# encoding: utf-8

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  module MonkeyPatch
    module Array
      # 2048 related methods
      module Board
        def hashinize
          col_row = [0, 1, 2, 3].product([0, 1, 2, 3])
          col_row.each_with_object({}) do |(col, row), memo|
            tile = self[col][row]
            memo[[col, row]] =
              tile.respond_to?(:status) ? tile : Text2048::Tile.new(tile)
          end
        end
      end
    end
  end
end
