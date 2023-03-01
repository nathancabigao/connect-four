# frozen_string_literal: true

require_relative '../lib/game'

describe 'Game' do
  subject(:game) { Game.new }

  describe '#player_input' do
    context 'when user input is within columns 1-7 and the column is not full' do
      subject(:game_input_valid) { Game.new }
      before do
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

    context 'when user input is invalid, followed by a valid input' do
      subject(:game_input_invalid_twice) { Game.new }
      before do
        invalid_input_one = '100'
        invalid_input_two = 'lol'
        valid_input = '7'
        allow(game_input_invalid_twice).to receive(:gets).and_return(invalid_input_one, invalid_input_two, valid_input)
      end
      it 'displays an error message and loops once' do
        error_message = 'Invalid column selection. Please enter the number of a column (1-7) that is not full.'
        expect(game_input_invalid_twice).to receive(:puts).with(error_message).exactly(2).times
        game_input_invalid_twice.player_input
      end
    end
  end
end
