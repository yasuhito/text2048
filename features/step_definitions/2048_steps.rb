# encoding: utf-8

require 'text2048'

Given(/^a board:$/) do |string|
  layout = string.split("\n").reduce([]) do |result, row|
    result << row.split(' ').map(&:to_i)
  end
  @view = Text2048::TextView.new(output)
  @board = Text2048::Board.new(layout)
end

When(/^I move the board to the right$/) do
  @board = @board.right
end

When(/^I move the board to the left$/) do
  @board = @board.left
end

When(/^I move the board up$/) do
  @board = @board.up
end

When(/^I move the board down$/) do
  @board = @board.down
end

Then(/^the board is:$/) do |string|
  @view.update(@board)
  output.messages.should eq(string)
end

Then(/^the score is (\d+)$/) do |score|
  @board.score.should eq(score.to_i)
end

Then(/^it is game over$/) do
  @board.lose?.should be_true
end
