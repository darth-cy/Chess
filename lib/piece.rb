require_relative 'board'

ROOK_DIRECTIONS = [[1,0], [0, 1], [-1, 0], [0, -1]]
QUEEN_DIRECTIONS = [[1,0], [0, 1], [-1, 0], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]
BISHOP_DIRECTIONS = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
# KNIGHT_STEPS
# KING_STEPS
# PAWN_STEPS

class Piece
  attr_reader :pos

  def initialize(color, pos, board = Board.empty_board)
    @color
    @pos = pos
    @board
  end


  def moves
    raise "Must implement in subclass!"
  end

  def valid?(pos)
    pos.all? { |el| el.between?(0,7) }
  end

end

class SlidingPiece < Piece
  attr_reader :directions


  def initialize(color, pos, board = Board.empty_board, directions = [])
    super(color, pos, board)
    @directions = directions
  end


  def slide
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

class Rook < SlidingPiece

end

class Queen < SlidingPiece

end

class Bishop < SlidingPiece

end






r = Rook.new(:W, [0,0], nil, ROOK_DIRECTIONS)
p r.slide
q = Queen.new(:W, [4,4], nil, QUEEN_DIRECTIONS)
p q.slide
b = Bishop.new(:W, [7,4], nil, BISHOP_DIRECTIONS)
p b.slide
