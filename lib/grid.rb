# frozen_string_literal: true

# Instantiates a grid to be used for Connect Four games.
class Grid
  def initialize(grid = create_new_grid)
    @grid = grid # grid[col][row]
  end

  def create_new_grid
    Array.new(7) { Array.new(6) } # Grid of 7 columns with 6 rows
  end
end
