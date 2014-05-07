# encoding: utf-8

require 'text2048/monkey_patch/array/board'
require 'text2048/monkey_patch/array/tile'

# Monkey-patched standard Array class.
class Array
  include Text2048::MonkeyPatch::Array::Board
  include Text2048::MonkeyPatch::Array::Tile
end
