# encoding: utf-8

require 'text2048/app'

describe Text2048::App do
  describe '.new' do
    context 'with no arguments' do
      When(:result) { Text2048::App.new }
      Then { result.view.is_a?(Text2048::CursesView) }
    end

    context 'with custom view' do
      Given(:view) { double('view') }
      When(:result) { Text2048::App.new(view) }
      Then { result.view == view }
    end
  end

  describe '#generate' do
    Given(:view) { double('view', update: nil, zoom_tiles: nil) }
    Given(:app) { Text2048::App.new(view) }

    context 'with no arguments' do
      When { app.generate }
      Then { app.board.generated_tiles.size == 1 }
    end

    context 'with 2' do
      When { app.generate(2) }
      Then { app.board.generated_tiles.size == 2 }
    end
  end

  describe '#step' do
    Given(:new_board) do
      double('new_board', merged_tiles: nil, generate?: nil)
    end

    context 'with command = :larger' do
      Given(:view) { double('view', command: :larger, larger: nil) }
      Given(:app) { Text2048::App.new(view) }
      When { app.step }
      Then { expect(view).to have_received(:larger) }
    end

    context 'with command = :smaller' do
      Given(:view) { double('view', command: :smaller, smaller: nil) }
      Given(:app) { Text2048::App.new(view) }
      When { app.step }
      Then { expect(view).to have_received(:smaller) }
    end

    context 'with command = :left' do
      Given(:view) do
        double('view', command: :left, update: nil, pop_tiles: nil)
      end
      Given(:board) { double('board', left: new_board, win?: nil, lose?: nil) }
      Given(:app) { Text2048::App.new(view, board) }
      When { app.step }
      Then { expect(board).to have_received(:left) }
      And { expect(view).to have_received(:update) }
    end

    context 'with command = :right' do
      Given(:view) do
        double('view', command: :right, update: nil, pop_tiles: nil)
      end
      Given(:board) do
        double('board', right: new_board, win?: nil, lose?: nil)
      end
      Given(:app) { Text2048::App.new(view, board) }
      When { app.step }
      Then { expect(board).to have_received(:right) }
      And { expect(view).to have_received(:update) }
    end

    context 'with command = :up' do
      Given(:view) do
        double('view', command: :up, update: nil, pop_tiles: nil)
      end
      Given(:board) { double('board', up: new_board, win?: nil, lose?: nil) }
      Given(:app) { Text2048::App.new(view, board) }
      When { app.step }
      Then { expect(board).to have_received(:up) }
      And { expect(view).to have_received(:update) }
    end

    context 'with command = :down' do
      Given(:view) do
        double('view', command: :down, update: nil, pop_tiles: nil)
      end
      Given(:board) { double('board', down: new_board, win?: nil, lose?: nil) }
      Given(:app) { Text2048::App.new(view, board) }
      When { app.step }
      Then { expect(board).to have_received(:down) }
      And { expect(view).to have_received(:update) }
    end
  end
end
