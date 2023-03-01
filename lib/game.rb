# frozen_string_literal: true

require_relative 'grid'
require_relative 'player'

# Used to create games of Connect 4.
class Game
  attr_reader :grid, :player_one, :player_two, :current_player, :turn

  def initialize
    @grid = Grid.new
    @player_one = Player.new(1, "\u26AA")
    @player_two = Player.new(2, "\u26AB")
    @current_player = @player_one
    @turn = 0
  end

  def play
    welcome_message
    until @grid.game_over? || @turn >= 42
      @grid.display_grid
      player_input
      @turn += 1
      toggle_player unless @grid.game_over?
    end
    @grid.display_grid
    end_message
  end

  # Gets a column number from the player to place their token into
  def player_input
    loop do
      puts "Player #{@current_player.player_no} (#{@current_player.token}), your turn:"
      col = gets.chomp.to_i
      error_message = 'Invalid column selection. Please enter the number of a column (1-7) that is not full.'
      return unless @grid.place_token(@current_player.token, col - 1) == error_message

      puts error_message
    end
  end

  def toggle_player
    @current_player = @current_player == @player_one ? @player_two : @player_one
  end

  def end_message
    if @turn >= 42
      puts "It's a tie! Game over."
    else
      puts "Player #{@current_player.player_no} (#{@current_player.token}) wins!"
    end
  end

  private

  def welcome_message
    puts 'Welcome to Connect Four!'
    puts 'Connect Four is a two-player game where players take turns placing their tokens into a grid, competing to respectively have four consecutive tokens placed in a row, column, or diagonal.'
    puts "To play, simply enter the number (1-7) of the column you wish to place your piece into, and play until a winner is decided!\n"
  end
end
