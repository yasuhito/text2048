# encoding: utf-8

require 'forwardable'
require 'text2048/monkey_patch/array'
require 'text2048/tile'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  # Each row or column of a game board.
  class Tiles
    extend Forwardable

    attr_reader :score

    def initialize(list, score = 0)
      @list = list.dup
      @score = score
    end

    def right
      list, score = list_status_cleared.rshrink.rmerge
      self.class.new(list, score)
    end

    def left
      list, score = list_status_cleared.reverse.rshrink.rmerge
      self.class.new(list.reverse, score)
    end

    def to_a
      @list
    end

    def_delegators :@list, :[]

    private

    def list_status_cleared
      @list.map { |each| each && each.clear_status }
    rescue NoMethodError
      @list.dup
    end
  end
end
