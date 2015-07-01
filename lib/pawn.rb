require_relative 'stepping_piece'

class Pawn < SteppingPiece
  attr_reader :moved

  def initialize(color, pos, board_reference)
    super
    @moved = false
  end

  def has_moved
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
