require_relative 'sliding_piece'

class GodPiece < SlidingPiece
  GOD_DIRECTIONS = [1 , -1, 2, -2].permutation(2).to_a.reject { |direc| direc.first.abs == direc.last.abs }


  attr_reader :directions

  def initialize(color, pos, board_reference)
    super
    @directions = GOD_DIRECTIONS
  end

  def render
    @color == :W ? " G " : " G "
  end

  def dup(new_board)
    GodPiece.new(@color, @pos, new_board)
  end

end
