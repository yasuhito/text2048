# encoding: utf-8

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # Simple text view.
  class TextView
    def initialize(output)
      @output = output
    end

    def update(layout, _score)
      string = layout.map do |row|
        row.map { |num| num != 0 ? num : '_' }.join(' ')
      end.join("\n")
      @output.puts string
    end

    def pop_tiles(_list)
      # noop
    end

    def zoom_tiles(_list)
      # noop
    end
  end
end
