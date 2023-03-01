# frozen_string_literal: true

# Sets up a player to use for Connect 4 games
class Player
  attr_reader :player_no, :token

  def initialize(player_no, token)
    @player_no = player_no
    @token = token
  end
end
