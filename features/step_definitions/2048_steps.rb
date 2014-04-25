require 'text2048'

Given(/^a board:$/) do |string|
  layout = string.split("\n").reduce([]) do |result, row|
    result << row.split(' ').map(&:to_i)
  end
  @board = Text2048::Board.new(layout)
end

When(/^I move the board to the right$/) do
  @board.right!
end

When(/^I move the board to the left$/) do
  @board.left!
end

When(/^I move the board up$/) do
  @board.up!
end

When(/^I move the board down$/) do
  @board.down!
end

Then(/^the board is:$/) do |string|
  @board.to_s.should eq(string)
end

When(/^I start a new game$/) do
  Text2048::Game.new(output).start
end

Then(/^the board has two random numbers$/) do
  output.messages.split(//).select! { |each| /\d/=~ each }.size == 2
end

Then(/^the score is (\d+)$/) do |score|
  @board.score.should eq(score.to_i)
end
