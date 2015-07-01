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
