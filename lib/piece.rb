require_relative 'board'

ROOK_DIRECTIONS = [[1,0], [0, 1], [-1, 0], [0, -1]]
QUEEN_DIRECTIONS = [[1,0], [0, 1], [-1, 0], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]
BISHOP_DIRECTIONS = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
KNIGHT_STEPS = [1 , -1, 2, -2].permutation(2).to_a.reject { |direc| direc.first.abs == direc.last.abs }
KING_STEPS = [[1,0], [0, 1], [-1, 0], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]
# PAWN_STEPS

class Piece
  attr_reader :pos, :directions

  def initialize(color, pos, board = Board.empty_board, directions = [])
    @color
    @pos = pos
    @board
    @directions = directions
  end


  def moves
    raise "Must implement in subclass!"
  end

  def valid?(pos)
    pos.all? { |el| el.between?(0,7) }
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
        valid_moves << move if valid?(move)
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
      valid_moves << move if valid?(move)
    end

    valid_moves

  end

end


class Rook < SlidingPiece

end

class Queen < SlidingPiece

end

class Bishop < SlidingPiece

end

class King < SteppingPiece

end

class Knight < SteppingPiece

end

class Pawn < SteppingPiece

end






r = Rook.new(:W, [0,0], nil, ROOK_DIRECTIONS)
p r.moves
q = Queen.new(:W, [4,4], nil, QUEEN_DIRECTIONS)
p q.moves
b = Bishop.new(:W, [7,4], nil, BISHOP_DIRECTIONS)
p b.moves
k = King.new(:W, [7, 4], nil, KING_STEPS)
p  k.moves
kn = Knight.new(:W, [4, 4], nil, KNIGHT_STEPS)
p kn.moves
