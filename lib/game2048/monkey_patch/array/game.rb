# encoding: utf-8

module Game2048
  module MonkeyPatch
    module Array
      # 2048 related methods
      module Game
        def rmerge
          numbers = dup
          size.downto(1) do |each|
            if numbers[each - 1] == numbers[each]
              numbers[each] *= 2
              numbers[each - 1] = 0
            end
          end
          numbers
        end

        def rshrink
          numbers = dup
          orig_size = numbers.size
          numbers.select! { |each| each != 0 }
          ::Array.new(orig_size - numbers.size, 0) + numbers
        end
      end
    end
  end
end
