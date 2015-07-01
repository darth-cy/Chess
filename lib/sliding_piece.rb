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
