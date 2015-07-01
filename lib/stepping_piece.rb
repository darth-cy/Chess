require_relative 'piece'

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

class King < SteppingPiece
  KING_STEPS = [[1,0], [0, 1], [-1, 0], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]

  attr_reader :directions

  def initialize(*args)
    super(*args)
    @directions = KING_STEPS
  end

  def render
    @color == :W ? " \u2654 ".encode('utf-8') : " \u265A ".encode('utf-8')
  end

  def dup(new_board)
    King.new(@color, @pos, new_board)
  end

  def king?
    true
  end

end

class Knight < SteppingPiece
  KNIGHT_STEPS = [1 , -1, 2, -2].permutation(2).to_a.reject { |direc| direc.first.abs == direc.last.abs }

  attr_reader :directions

  def initialize(*args)
    super(*args)
    @directions = KNIGHT_STEPS
  end

  def render
    @color == :W ? " \u2658 ".encode('utf-8') : " \u265E ".encode('utf-8')
  end

  def dup(new_board)
    Knight.new(@color, @pos, new_board)
  end

end

class Pawn < SteppingPiece
  attr_reader :moved

  def initialize(*args)
    super(*args)
    @moved = false
  end

  def moved
    @moved = true
  end

  def is_pawn?
    true
  end

  def moves
    valid_moves = []

    row, col = self.pos
    attack = [[-1, -1], [-1, 1]]
    attack.map! { |el| [-el.first, el.last] } if @color == :B

    attack.each do |pos|
      move = [row + pos.first, col + pos.last]
      valid_moves << move if valid?(move) && enemy?(move)
    end

    step = (@color == :B) ? 1 : -1
    move = [row += step, col]
    return valid_moves if !valid?(move) || ally?(move) || enemy?(move)
    valid_moves << move

    move = [row += step, col]
    return valid_moves if @moved || !valid?(move) || ally?(move) || enemy?(move)
    valid_moves << move
    valid_moves

  end

  def render
    @color == :W ? " \u2659 ".encode('utf-8') : " \u265F ".encode('utf-8')
  end

  def dup(new_board)
    Pawn.new(@color, @pos, new_board)
  end

end
