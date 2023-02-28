# frozen_string_literal: true

# Instantiates a grid to be used for Connect Four games.
class Grid
  attr_reader :grid

  def initialize(grid = create_new_grid)
    @grid = grid # grid[col][row]
  end

  def create_new_grid
    Array.new(7) { Array.new(6) } # Grid of 7 columns with 6 rows
  end

  # Places token_char into the first available row in the given col if possible.
  def place_token(token_char, col)
    return 'Invalid column selection. Please enter the number of a column (1-7) that is not full.' if invalid_col(col)

    row = @grid[col].count { |slot| !slot.nil? }
    @grid[col][row] = token_char[0]
  end

  # Returns true if column is invalid (invalid column number, or column is full)
  def invalid_col(col)
    return true unless col.between?(0, 6)

    return true if @grid[col].all? { |slot| !slot.nil? } # all rows are full

    false
  end
end
