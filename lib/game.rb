# frozen_string_literal: true

require_relative 'grid'
require_relative 'player'

# Used to create games of Connect 4.
class Game
  attr_reader :grid, :player_one, :player_two, :current_player

  def initialize
    @grid = Grid.new
    @player_one = Player.new(1, "\u26AA")
    @player_two = Player.new(2, "\u26AB")
    @current_player = @player_one
  end

  # Gets a column number from the player to place their token into
  def player_input
    loop do
      col = gets.chomp.to_i
      error_message = 'Invalid column selection. Please enter the number of a column (1-7) that is not full.'
      return unless @grid.place_token(@current_player.token, col - 1) == error_message

      puts error_message
    end
  end

  def toggle_player
    @current_player = @current_player == @player_one ? @player_two : @player_one
  end
end
