# encoding: utf-8

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  module MonkeyPatch
    module Array
      # 2048 related methods
      module Tile
        def rmerge
          compact!
          score = (0..(size - 1)).to_a.reduce(0) do |memo, each|
            memo += merge_right(each) if merge_right?(each)
            memo
          end
          [fill_length(4), score]
        end

        def merge_right?(index)
          me = self[index]
          right = self[index + 1]
          me && me == right
        end

        def merge_right(index)
          value = self[index].to_i * 2
          self[index] = Text2048::Tile.new(value, :merged)
          delete_at(index + 1)
          value
        end

        def clear_status
          map { |each| each && each.clear_status }
        rescue NoMethodError
          dup
        end

        def fill_length(len)
          unshift(nil) until size == len
          self
        end
      end
    end
  end
end
