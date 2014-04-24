require 'game2048'

Given(/^a board:$/) do |string|
  layout = string.split.reduce([]) do |result, row|
    result << row.split(//).map { |each| each.to_i }
  end
  @board = Game2048::Board.new(layout)
end

When(/^I hit the right key$/) do
  @board.right!
end

When(/^I hit the left key$/) do
  @board.left!
end

When(/^I hit the up key$/) do
  @board.up!
end

When(/^I hit the down key$/) do
  @board.down!
end

Then(/^the board is:$/) do |string|
  @board.to_s.should eq(string)
end
