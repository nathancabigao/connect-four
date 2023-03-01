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

  def display_grid
    puts "\n| 1  | 2  | 3  | 4  | 5  | 6  | 7  |"
    puts '------------------------------------'
    6.times.reverse_each do |row|
      print '|'
      7.times do |col|
        slot_char = @grid[col][row].nil? ? '  ' : @grid[col][row]
        print " #{slot_char} |"
      end
      print "\n"
    end
  end

  def place_token(token_char, col)
    return 'Invalid column selection. Please enter the number of a column (1-7) that is not full.' if invalid_col?(col)

    row = @grid[col].count { |slot| !slot.nil? }
    @grid[col][row] = token_char[0]
  end

  def game_over?
    return true if column_win?

    return true if row_win?

    return true if diagonal_win?

    false
  end

  private

  def invalid_col?(col)
    return true unless col.between?(0, 6)

    return true if @grid[col].all? { |slot| !slot.nil? }

    false
  end

  def winning_combination?(combination)
    combination.uniq.size == 1 && !combination.uniq.include?(nil)
  end

  def column_win?
    7.times do |col|
      3.times do |row|
        combination = @grid[col][row..row + 3]
        return true if winning_combination?(combination)
      end
    end
    false
  end

  def row_win?
    6.times.reverse_each do |row|
      4.times do |col|
        combination = []
        (col..col + 3).each { |col_to_add| combination << @grid[col_to_add][row] }
        return true if winning_combination?(combination)
      end
    end
    false
  end

  def diagonal_win?
    return true if diagonal_up_win?

    return true if diagonal_down_win?

    false
  end

  def diagonal_up_win?
    4.times.reverse_each do |col|
      3.times do |row|
        combination = []
        4.times do |next_slot|
          combination << @grid[col + next_slot][row + next_slot]
        end
        return true if winning_combination?(combination)
      end
    end
    false
  end

  def diagonal_down_win?
    4.times do |col|
      (3..5).each do |row|
        combination = []
        4.times do |next_slot|
          combination << @grid[col + next_slot][row - next_slot]
        end
        return true if winning_combination?(combination)
      end
    end
    false
  end
end
