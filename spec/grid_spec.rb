# frozen_string_literal: true

require_relative '../lib/grid'

describe 'Grid' do
  subject(:grid_test) { Grid.new }

  describe '#create_new_grid' do
    matcher :be_row_len_six do
      match { |row| row.length == 6 }
    end
    it 'returns an empty array with 7 columns' do
      new_grid = grid_test.create_new_grid
      expect(new_grid.length).to be(7)
    end
    it 'returns an empty array with 6 rows in each column' do
      new_grid = grid_test.create_new_grid
      expect(new_grid).to all(be_row_len_six)
    end
  end

  describe '#place_token' do
    context 'when the selected column is empty' do
      subject(:grid_place_empty) { Grid.new }
      it 'puts the token in the empty column, bottom row' do
        token_char = "\u26AA"
        col = 0
        expect { grid_place_empty.place_token(token_char, col) }.to change { grid_place_empty.grid[col][0] }.from(nil).to("\u26AA")
      end
      it 'keeps only the first character if the token character was a string with 2+ characters' do
        token_string = 'string'
        col = 1
        expect { grid_place_empty.place_token(token_string, col) }.to change { grid_place_empty.grid[col][0] }.from(nil).to('s')
      end
    end
    context 'when the selected column has tokens, but is not full' do
      grid_with_partial_column = Array.new(7) { Array.new(6) }
      grid_with_partial_column[0] = ["\u26AA", "\u26AA", "\u26AA", nil, nil, nil]
      subject(:grid_place_half) { Grid.new(grid_with_partial_column) }
      it 'puts the token in the empty column, lowest available row' do
        token_char = "\u26AA"
        col = 0
        expected_row = grid_place_half.grid[col].count { |slot| !slot.nil? }
        expect { grid_place_half.place_token(token_char, col) }.to change { grid_place_half.grid[col][expected_row] }.from(nil).to("\u26AA")
      end
    end
    context 'when the selected column is full' do
      grid_with_full_column = Array.new(7) { Array.new(6) }
      grid_with_full_column[0] = ["\u26AA", "\u26AA", "\u26AA", "\u26AB", "\u26AB", "\u26AB"]
      subject(:grid_place_full) { Grid.new(grid_with_full_column) }
      it 'returns an invalid column message' do
        token_char = "\u26AA"
        col = 0
        invalid_col_message = 'Invalid column selection. Please enter the number of a column (1-7) that is not full.'
        expect(grid_place_full.place_token(token_char, col)).to eq(invalid_col_message)
      end
    end
    context 'when the given column number is invalid' do
      subject(:grid_place_invalid) { Grid.new }
      it 'returns an invalid column message' do
        token_char = "\u26AA"
        col = 8
        invalid_col_message = 'Invalid column selection. Please enter the number of a column (1-7) that is not full.'
        expect(grid_place_invalid.place_token(token_char, col)).to eq(invalid_col_message)
      end
    end
  end
end
