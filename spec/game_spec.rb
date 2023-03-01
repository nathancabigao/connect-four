# frozen_string_literal: true

require_relative '../lib/game'

describe 'Game' do
  subject(:game) { Game.new }

  describe '#player_input' do
    context 'when user input is within columns 1-7 and the column is not full' do
      subject(:game_input_valid) { Game.new }
      before do
        allow(game_input_valid).to receive(:puts)
        valid_input = '3'
        allow(game_input_valid).to receive(:gets).and_return(valid_input)
      end
      it 'stops loop and does not display error message' do
        error_message = 'Invalid column selection. Please enter the number of a column (1-7) that is not full.'
        expect(game_input_valid).not_to receive(:puts).with(error_message)
        game_input_valid.player_input
      end
    end

    context 'when user input is within columns 1-7 but the column is full, followed by a valid input' do
      subject(:game_input_full) { Game.new }
      before do
        allow(game_input_full).to receive(:puts)
        full_column_array = [["\u26AA", "\u26AA", "\u26AA", "\u26AB", "\u26AB", "\u26AB"],
                             [nil, nil, nil, nil, nil, nil],
                             [nil, nil, nil, nil, nil, nil],
                             [nil, nil, nil, nil, nil, nil],
                             [nil, nil, nil, nil, nil, nil],
                             [nil, nil, nil, nil, nil, nil],
                             [nil, nil, nil, nil, nil, nil]]
        full_column_grid = Grid.new(full_column_array)
        game_input_full.instance_variable_set(:@grid, full_column_grid)
        valid_input_full = '1'
        valid_input = '2'
        allow(game_input_full).to receive(:gets).and_return(valid_input_full, valid_input)
      end
      it 'displays an error message and loops once' do
        error_message = 'Invalid column selection. Please enter the number of a column (1-7) that is not full.'
        expect(game_input_full).to receive(:puts).with(error_message).exactly(1).time
        game_input_full.player_input
      end
    end

    context 'when user input is invalid, followed by a valid input' do
      subject(:game_input_invalid) { Game.new }
      before do
        allow(game_input_invalid).to receive(:puts)
        invalid_input = '64s'
        valid_input = '2'
        allow(game_input_invalid).to receive(:gets).and_return(invalid_input, valid_input)
      end
      it 'displays an error message and loops once' do
        error_message = 'Invalid column selection. Please enter the number of a column (1-7) that is not full.'
        expect(game_input_invalid).to receive(:puts).with(error_message).exactly(1).time
        game_input_invalid.player_input
      end
    end

    context 'when user input is invalid 2 times, followed by a valid input' do
      subject(:game_input_invalid_twice) { Game.new }
      before do
        allow(game_input_invalid_twice).to receive(:puts)
        invalid_input_one = '100'
        invalid_input_two = 'lol'
        valid_input = '7'
        allow(game_input_invalid_twice).to receive(:gets).and_return(invalid_input_one, invalid_input_two, valid_input)
      end
      it 'displays an error message and loops twice' do
        error_message = 'Invalid column selection. Please enter the number of a column (1-7) that is not full.'
        expect(game_input_invalid_twice).to receive(:puts).with(error_message).exactly(2).times
        game_input_invalid_twice.player_input
      end
    end
  end

  describe '#toggle_player' do
    context 'when player 1' do
      subject(:game_toggle_one) { Game.new }
      it 'changes from player 1 to player 2' do
        expect { game_toggle_one.toggle_player }.to change { game_toggle_one.current_player }.from(game_toggle_one.player_one).to(game_toggle_one.player_two)
      end
    end

    context 'when player 2' do
      subject(:game_toggle_two) { Game.new }
      before do
        game_toggle_two.instance_variable_set(:@current_player, game_toggle_two.player_two)
      end
      it 'changes from player 2 to player 1' do
        expect { game_toggle_two.toggle_player }.to change { game_toggle_two.current_player }.from(game_toggle_two.player_two).to(game_toggle_two.player_one)
      end
    end
  end

  describe '#end_message' do
    context 'when the grid fills up completely, with no winner' do
      subject(:game_end_tie) { Game.new }
      before do
        game_end_tie.instance_variable_set(:@turn, 42)
      end
      it 'the message indicates a tie' do
        tie_message = "It's a tie! Game over."
        expect(game_end_tie).to receive(:puts).with(tie_message)
        game_end_tie.end_message
      end
    end

    context "when the game ends during player one's turn" do
      subject(:game_end_one) { Game.new }
      it "the message correctly displays player one's win" do
        player_one_message = "Player 1 (\u26AA) wins!"
        expect(game_end_one).to receive(:puts).with(player_one_message)
        game_end_one.end_message
      end
    end

    context "when the game ends during player two's turn" do
      subject(:game_end_two) { Game.new }
      before do
        game_end_two.instance_variable_set(:@current_player, game_end_two.player_two)
      end
      it "the message correctly displays player two's win" do
        player_two_message = "Player 2 (\u26AB) wins!"
        expect(game_end_two).to receive(:puts).with(player_two_message)
        game_end_two.end_message
      end
    end
  end
end
