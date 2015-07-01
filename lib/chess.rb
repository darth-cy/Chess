require_relative 'keypress'
require_relative 'masterboard'
require 'byebug'
require 'yaml'

class Chess
  include Keypress

  def initialize
    @board = MasterBoard.new
    @players = [:B, :W]
  end

  def start
    puts "Load from saved file? (y/n)"
    to_load = (gets.chomp.to_s.strip.downcase == "y")
    if to_load
      state = File.read("saved_game.txt")
      game = YAML.load(state)
      game.play
    else
      play
    end
  end

  def play
    until over?
      take_turn
    end
    @board.render(@players.last)
    if checkmate?
      puts "FINISHED. #{@players.last} is in checkmate and lost the game."
    else
      puts "FINISHED. It is #{@players.last}'s turn and the game is a stalemate"
    end
  end

  def take_turn
    switch_player
    @board.to_move
    player = @players.first
    until @board.moved?
      @board.render(player)
      command = read_single_key
      if command == "SAVE"
        save_game
      else
        @board.read_command(player, command)
      end
    end
  end

  def save_game
    puts "Save Game? (y/n)"
    to_save = (gets.chomp.to_s.strip.downcase == "y")
    if to_save
      switch_player
      state = self.to_yaml
      File.open("saved_game.txt", 'w') { |f| f.write(state) }
    end
  end

  def switch_player
    @players.rotate!
  end

  def checkmate?
    @board.in_check?(@players.last) && @board.checkmate?(@players.last)
  end

  def stalemate?
    !@board.in_check?(@players.last) && @board.checkmate?(@players.last)
  end

  def over?
    checkmate? || stalemate?
  end
end

chess = Chess.new
chess.start
