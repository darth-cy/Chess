require_relative 'piece'

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

class Rook < SlidingPiece
  ROOK_DIRECTIONS = [[1,0], [0, 1], [-1, 0], [0, -1]]

  attr_reader :directions

  def initialize(*args)
    super(*args)
    @directions = ROOK_DIRECTIONS
  end

  def render
    @color == :W ? " \u2656 ".encode('utf-8') : " \u265C ".encode('utf-8')
  end

  def dup(new_board)
    Rook.new(@color, @pos, new_board)
  end

end

class Queen < SlidingPiece
  QUEEN_DIRECTIONS = [[1,0], [0, 1], [-1, 0], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]

  attr_reader :directions

  def initialize(*args)
    super(*args)
    @directions = QUEEN_DIRECTIONS
  end

  def render
    @color == :W ? " \u2655 ".encode('utf-8') : " \u265B ".encode('utf-8')
  end

  def dup(new_board)
    Queen.new(@color, @pos, new_board)
  end

end

class Bishop < SlidingPiece
  BISHOP_DIRECTIONS = [[1, 1], [1, -1], [-1, 1], [-1, -1]]

  attr_reader :directions

  def initialize(*args)
    super(*args)
    @directions = BISHOP_DIRECTIONS
  end

  def render
    @color == :W ? " \u2657 ".encode('utf-8') : " \u265D ".encode('utf-8')
  end

  def dup(new_board)
    Bishop.new(@color, @pos, new_board)
  end

end
