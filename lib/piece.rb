require_relative 'board'
require 'time'
require 'byebug'

ROOK_DIRECTIONS = [[1,0], [0, 1], [-1, 0], [0, -1]]
QUEEN_DIRECTIONS = [[1,0], [0, 1], [-1, 0], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]
BISHOP_DIRECTIONS = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
KNIGHT_STEPS = [1 , -1, 2, -2].permutation(2).to_a.reject { |direc| direc.first.abs == direc.last.abs }
KING_STEPS = [[1,0], [0, 1], [-1, 0], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]
PAWN_STEPS = []

class Piece
  attr_reader :pos, :directions, :board, :color

  def initialize(color, pos, board = Board.empty_board, directions = [])
    @color = color
    @pos = pos
    @board = board
    @directions = directions
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

  def dup
    Piece.new(@color, @pos, @board, @directions)
  end

  def render
    raise "Piece should not render (ambiguous piece)."
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

class SlidingPiece < Piece

  def moves
    valid_moves = []

    self.directions.each do |direc|
      row, col = self.pos
      move = self.pos
      until !valid?(move)
        move = [row += direc.first, col += direc.last]
        break if !valid?(move) || ally?(move)
        valid_moves << move
        break if enemy?(move)
      end

    end
    valid_moves
  end

end

class SteppingPiece < Piece

  def moves
    valid_moves = []

    self.directions.each do |direc|
      row, col = self.pos
      move = [row += direc.first, col += direc.last]
      next if !valid?(move) || ally?(move)
      valid_moves << move
    end

    valid_moves

  end

end


class Rook < SlidingPiece

  def render
    @color == :W ? " \u2656 ".encode('utf-8') : " \u265C ".encode('utf-8')
  end

  def dup
    Rook.new(@color, @pos, @board, @directions)
  end

end

class Queen < SlidingPiece

  def render
    @color == :W ? " \u2655 ".encode('utf-8') : " \u265B ".encode('utf-8')
  end

  def dup
    Queen.new(@color, @pos, @board, @directions)
  end

end

class Bishop < SlidingPiece

  def render
    @color == :W ? " \u2657 ".encode('utf-8') : " \u265D ".encode('utf-8')
  end

  def dup
    Bishop.new(@color, @pos, @board, @directions)
  end

end

class King < SteppingPiece

  def render
    @color == :W ? " \u2654 ".encode('utf-8') : " \u265A ".encode('utf-8')
  end

  def dup
    King.new(@color, @pos, @board, @directions)
  end

  def king?
    true
  end

end

class Knight < SteppingPiece

  def render
    @color == :W ? " \u2658 ".encode('utf-8') : " \u265E ".encode('utf-8')
  end

  def dup
    Knight.new(@color, @pos, @board, @directions)
  end

end

class Pawn < SteppingPiece
  attr_reader :moved

  def initialize(color, pos, board = Board.empty_board, directions = [])
    super(color, pos, board = Board.empty_board, directions = [])
    @moved = false
  end

  def moves
    valid_moves = []

    row, col = self.pos
    attack = [[-1, -1], [-1, 1]]
    attack.map! { |el| el.first *= -1 } if @color == :B

    attack.each do |pos|
      move = [row + pos.first, col + pos.last]
      valid_moves << move if valid?(move) && enemy?(move)
    end

    step = (@color == :B) ? 1 : -1
    move = [row += step, col]
    return valid_moves if !valid?(move) || ally?(move)
    valid_moves << move

    move = [row += step, col]
    return valid_moves if @moved || !valid?(move) || ally?(move) || enemy?(move)
    valid_moves << move
    valid_moves

  end

  def render
    @color == :W ? " \u2659 ".encode('utf-8') : " \u265F ".encode('utf-8')
  end

  def dup
    Pawn.new(@color, @pos, @board, @directions)
  end

end








# r = Rook.new(:W, [0,0], Board.new, ROOK_DIRECTIONS)
# q = Queen.new(:W, [4,4], Board.new , QUEEN_DIRECTIONS)
# p q.moves.count
# b = Bishop.new(:W, [7,4], Board.new, BISHOP_DIRECTIONS)
# p b.moves
# k = King.new(:W, [2, 2], Board.new, KING_STEPS)
# k.board.rows[1][1] = Knight.new(:W, [1,1], Board.new, KNIGHT_STEPS)
# k.board.rows[2][1] = Knight.new(:B, [2,1], Board.new, KNIGHT_STEPS)
# p  k.moves.count
# kn = Knight.new(:W, [7, 7],Board.new, KNIGHT_STEPS)
# pawn = Pawn.new(:W, [4, 4], Board.new, PAWN_STEPS)
# pawn.board.rows[2][4] = Knight.new(:B, [2,4], Board.new, KNIGHT_STEPS)
# p pawn.moves

start = Time.now

b = Board.standard_board
#c = b.dup
b.rows[6][3] = King.new(:B, [6, 3], b, KING_STEPS)
#puts
b.render
p b.in_check?(:B)
#puts
#p c.rows[4][4].moves.count


end_t = Time.now

puts "Used Time: #{end_t - start}"
