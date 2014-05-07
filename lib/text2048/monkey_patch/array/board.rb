# encoding: utf-8

require 'text2048/tile'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  module MonkeyPatch
    module Array
      # 2048 related methods
      module Board
        def to_h
          tiles = {}
          [0, 1, 2, 3].product([0, 1, 2, 3]).each do |col, row|
            tiles[[col, row]] = self[col][row]
          end
          tiles
        end
      end
    end
  end
end
