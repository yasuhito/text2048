# encoding: utf-8

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # High score manager
  class HighScore
    DB_FILE = File.expand_path('~/.text2048')

    def initialize
      @score = 0
      load
    end

    def load
      @score = IO.read(DB_FILE).to_i if FileTest.exists?(DB_FILE)
      @score
    end

    def maybe_update(score)
      load
      save(score) if score > @score
    end

    def to_i
      @score
    end

    private

    def save(score)
      File.open(DB_FILE, 'w') { |file| file.print score }
      @score = score
    end
  end
end
