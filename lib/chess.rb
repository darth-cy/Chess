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
    @board.render(@players.last)
    puts "FINISHED. #{@players.last} is in checkmate and lost the game."
  end

  def take_turn
    switch_player
    @board.to_move
    player = @players.first
    until @board.moved?
      @board.render(player)
      command = read_single_key
      @board.read_command(player, command)
    end
  end

  def switch_player
    @players.rotate!
  end

  def over?
    if @board.in_check?(@players.last)
      @board.checkmate?(@players.last)
  #  elsif @board.stalemate?(players.last)
      #
    end
  end
end

chess = Chess.new
chess.play
