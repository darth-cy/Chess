require_relative 'player'
require_relative 'ai'
require_relative 'masterboard'
require 'byebug'
require 'yaml'

class Chess

  def initialize
    @board = MasterBoard.new
    @colors = [:B, :W]
    @players = {:B => ComputerPlayer.new(:B), :W => Player.new }
    #@players = {:B => ComputerPlayer.new(:B), :W => Player.new }
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
    @board.render(@colors.last)
    if checkmate?
      puts "FINISHED. #{@colors.last} is in checkmate and lost the game."
    else
      puts "FINISHED. It is #{@colors.last}'s turn and the game is a stalemate"
    end
  end

  def take_turn
    switch_color
    @board.to_move
    color = @colors.first
    until @board.moved?
      if @players[color].require_board?
        @players[color].pass_board(@board.dup, @board.highlighted_cell)
      end
      @board.render(color)
      
      command = @players[color].get_move

      if command == "SAVE"
        save_game
      else
        @board.read_command(color, command)
      end
    end
  end

  def save_game
    puts "Save Game? (y/n)"
    to_save = (gets.chomp.to_s.strip.downcase == "y")
    if to_save
      switch_color
      state = self.to_yaml
      File.open("saved_game.txt", 'w') { |f| f.write(state) }
    end
  end

  def switch_color
    @colors.rotate!
  end

  def checkmate?
    @board.in_check?(@colors.last) && @board.checkmate?(@colors.last)
  end

  def stalemate?
    !@board.in_check?(@colors.last) && @board.checkmate?(@colors.last)
  end

  def over?
    checkmate? || stalemate?
  end
end

chess = Chess.new
chess.start
