# encoding: utf-8

require 'text2048'

Given(/^a board:$/) do |string|
  layout = string.split("\n").reduce([]) do |result, row|
    result << row.split(' ').map(&:to_i)
  end
  @view = Text2048::TextView.new(output)
  @game = Text2048::Game.new(Text2048::Board.new(layout))
end

When(/^I move the board to the right$/) do
  @game.right!
end

When(/^I move the board to the left$/) do
  @game.left!
end

When(/^I move the board up$/) do
  @game.up!
end

When(/^I move the board down$/) do
  @game.down!
end

Then(/^the board is:$/) do |string|
  @view.update(@game)
  output.messages.should eq(string)
end

Then(/^the score is (\d+)$/) do |score|
  @game.score.should eq(score.to_i)
end

Then(/^it is game over$/) do
  @game.lose?.should be_true
end
