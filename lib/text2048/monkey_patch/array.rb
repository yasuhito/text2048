require 'text2048/monkey_patch/array/game'

# Monkey-patched standard Array class.
class Array
  include Text2048::MonkeyPatch::Array::Game
end
