require_relative 'stepping_piece'

class King < SteppingPiece
  KING_STEPS = [[1,0], [0, 1], [-1, 0], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]

  attr_reader :directions

  def initialize(color, pos, board_reference)
    super
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
