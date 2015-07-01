require_relative 'stepping_piece'

class Knight < SteppingPiece
  KNIGHT_STEPS = [1 , -1, 2, -2].permutation(2).to_a.reject { |direc| direc.first.abs == direc.last.abs }

  attr_reader :directions

  def initialize(color, pos, board_reference)
    super
    @directions = KNIGHT_STEPS
  end

  def render
    @color == :W ? " \u2658 ".encode('utf-8') : " \u265E ".encode('utf-8')
  end

  def dup(new_board)
    Knight.new(@color, @pos, new_board)
  end
end
