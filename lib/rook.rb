require_relative 'sliding_piece'

class Rook < SlidingPiece
  ROOK_DIRECTIONS = [[1,0], [0, 1], [-1, 0], [0, -1]]

  attr_reader :directions

  def initialize(color, pos, board_reference)
    super
    @directions = ROOK_DIRECTIONS
  end

  def render
    @color == :W ? " \u2656 ".encode('utf-8') : " \u265C ".encode('utf-8')
  end

  def dup(new_board)
    Rook.new(@color, @pos, new_board)
  end
end
