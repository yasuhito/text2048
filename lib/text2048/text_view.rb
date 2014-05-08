# encoding: utf-8

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # Simple text view.
  class TextView
    # Board row in text.
    class Row
      def initialize(row)
        @row = row
      end

      def to_s
        @row.map { |each| each != 0 ? each : '_' }.join(' ')
      end
    end

    def initialize(output = STDOUT)
      @output = output
    end

    def update(board)
      @output.puts board.to_a.map { |row| Row.new(row).to_s }.join("\n")
    end

    def pop_tiles(_list)
      # noop
    end

    def zoom_tiles(_list)
      # noop
    end
  end
end
