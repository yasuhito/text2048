# encoding: utf-8

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  module MonkeyPatch
    module Array
      # 2048 related methods
      module Tile
        def right
          shrink
          score = (size - 1).downto(1).reduce(0) do |memo, each|
            memo + (self[each] == self[each - 1] ? merge_left(each) : 0)
          end
          [fill_length(4), score]
        end

        def merge_left(index)
          value = self[index].to_i * 2
          self[index] = Text2048::Tile.new(value, :merged)
          self[index - 1] = nil
          value
        end

        def shrink
          delete(0)
          map!(&:clear_status)
        end

        def fill_length(len)
          compact!
          unshift(Text2048::Tile.new(nil)) until size == len
          self
        end
      end
    end
  end
end
