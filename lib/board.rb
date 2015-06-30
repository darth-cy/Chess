class Board
  attr_accessor :rows

  def initialize
    @rows = 1
  end

  def self.empty_board
    b = Board.new
    b.rows = Array.new(8) { Array.new(8) {nil} }
    return b
  end


end
