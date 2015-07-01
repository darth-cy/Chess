require_relative 'keypress'
require_relative 'masterboard'
require 'byebug'

class Chess
  attr_reader :current_player

  def initialize
    @board = MasterBoard.new
    @players = [:B, :W]
    @current_player = :W
  end

  def play

    until over?

      take_turn

    end

    puts "FINISHED. #{@players.last} is in checkmate and lost the game."

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
    @current_player = @players.rotate!.first
  end

  def over?
    @board.checkmate?(@players.last)
  end

end

chess = Chess.new
chess.play
