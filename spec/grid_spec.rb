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
end
