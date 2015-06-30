require "colorize"
require 'byebug'

class Board
  attr_accessor :rows

  def initialize
    @rows = Array.new(8) { Array.new(8) { EmptyPiece.new } }
    # @rows[1][1] = Pawn.new(:B, [1,1], 7, PAWN_STEPS)
    # @rows[1][2] = Pawn.new(:W, [1,2], 7, PAWN_STEPS)
    (0..7).each do |idx|
      @rows[1][idx] = Pawn.new(:B, [1, idx], 7, PAWN_STEPS)
      @rows[6][idx] = Pawn.new(:W, [1, idx], 7, PAWN_STEPS)
    end

    player = :B
    row_idxs = [0, -1]
    col_idxs = (0..7).to_a
    row_idxs.each do |row_idx|
      player = :W if row_idx == -1
      col_idxs.each do |col|
        case col
        when 0, 7
          @rows[row_idx][col] = Rook.new(player, [row_idx, col], 7, ROOK_DIRECTIONS)
        when 1, 6
          @rows[row_idx][col] = Knight.new(player, [row_idx, col], 7, KNIGHT_STEPS)
        when 2, 5
          @rows[row_idx][col] = Bishop.new(player, [row_idx, col], 7, BISHOP_DIRECTIONS)
        when 3
          @rows[row_idx][col] = Queen.new(player, [row_idx, col], 7, QUEEN_DIRECTIONS)
        when 4
          @rows[row_idx][col] = King.new(player, [row_idx, col], 7, KING_STEPS)
        end
      end
    end

  end

  def self.empty_board
    nil
  end

  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  def render
    @rows.each_with_index do |row, r_idx|
      row.each_with_index do |cell, c_idx|
        color = (r_idx + c_idx) % 2 == 0 ? :red : :black
        print cell.render.colorize(:background => color)
      end
      puts
    end
  end

end
