require 'time'
require 'byebug'

class Piece
  attr_reader :pos, :board, :color

  def initialize(color, pos, board = Board.empty_board)
    @color = color
    @pos = pos
    @board = board
  end

  def moves
    raise "Must implement in subclass!"
  end

  def valid?(pos)
    pos.all? { |el| el.between?(0,7) }
  end

  def enemy?(pos)
    @board[pos].is_enemy?(@color)
  end

  def ally?(pos)
    @board[pos].is_ally?(@color)
  end

  def is_enemy?(color)
    @color != color
  end

  def is_ally?(color)
    @color == color
  end

  def king?
    false
  end

  def dup(new_board)
    raise "Should not dup ambiguous piece."
  end

  def render
    raise "Piece should not render (ambiguous piece)."
  end

  def change_pos(pos)
    @pos = pos
  end

  def is_pawn?
    false
  end
end

class EmptyPiece < Piece
  def initialize

  end

  def is_enemy?(color)
    false
  end

  def is_ally?(color)
    false
  end

  def render
    "   "
  end

  def moves
    []
  end

  def dup
    EmptyPiece.new
  end
end
