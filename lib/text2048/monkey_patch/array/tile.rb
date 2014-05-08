# encoding: utf-8

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  module MonkeyPatch
    module Array
      # 2048 related methods
      module Tile
        def rmerge
          compact!
          score = (size - 1).downto(1).to_a.reduce(0) do |memo, each|
            memo += merge_left(each) if merge_left?(each)
            memo
          end
          [fill_length(4), score]
        end

        def merge_left?(index)
          me = self[index]
          left = self[index - 1]
          me && me == left
        end

        def merge_left(index)
          value = self[index].to_i * 2
          self[index] = Text2048::Tile.new(value, :merged)
          self[index - 1] = nil
          value
        end

        def clear_status
          map { |each| each && each.clear_status }
        rescue NoMethodError
          dup
        end

        def fill_length(len)
          compact!
          unshift(nil) until size == len
          self
        end
      end
    end
  end
end
