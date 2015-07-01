require_relative 'sliding_piece'

class Bishop < SlidingPiece
  BISHOP_DIRECTIONS = [[1, 1], [1, -1], [-1, 1], [-1, -1]]

  attr_reader :directions

  def initialize(color, pos, board_reference)
    super
    @directions = BISHOP_DIRECTIONS
  end

  def render
    @color == :W ? " \u2657 ".encode('utf-8') : " \u265D ".encode('utf-8')
  end

  def dup(new_board)
    Bishop.new(@color, @pos, new_board)
  end
end
