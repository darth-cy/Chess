require_relative 'keypress'
require_relative 'masterboard'
require 'byebug'

class Chess

  def initialize
    @board = MasterBoard.new
    @players = [:B, :W]
  end

  def play

    until over?

      take_turn

    end



  end

  def take_turn
    @board.to_move
    player = switch_player

    until @board.moved?
      @board.render
      command = read_single_key
      @board.read_command(player, command)
    end

  end


  def switch_player
    @players.rotate!.first
  end

  def over?

  end

end




chess = Chess.new
chess.play
