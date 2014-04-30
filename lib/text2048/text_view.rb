module Text2048
  # Simple text view.
  class TextView
    def initialize(output)
      @output = output
    end

    def draw(layout, _score)
      string = layout.map do |row|
        row.map { |num| num != 0 ? num : '_' }.join(' ')
      end.join("\n")
      @output.puts string
    end
  end
end
