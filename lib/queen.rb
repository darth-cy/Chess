require_relative 'sliding_piece'

class Queen < SlidingPiece
  QUEEN_DIRECTIONS = [[1,0], [0, 1], [-1, 0], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]

  attr_reader :directions

  def initialize(color, pos, board_reference)
    super
    @directions = QUEEN_DIRECTIONS
  end

  def render
    @color == :W ? " \u2655 ".encode('utf-8') : " \u265B ".encode('utf-8')
  end

  def dup(new_board)
    Queen.new(@color, @pos, new_board)
  end

end
