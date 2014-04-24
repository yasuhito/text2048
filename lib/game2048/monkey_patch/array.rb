require 'game2048/monkey_patch/array/game'

class Array
  include Game2048::MonkeyPatch::Array::Game
end
