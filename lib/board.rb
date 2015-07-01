require "colorize"
require 'byebug'

class Board
  attr_accessor :rows

  def initialize
    @rows = Array.new(8) { Array.new(8) { EmptyPiece.new } }
  end

  def self.standard_board
    b = Board.new
    b.set_pieces

    b
  end

  def set_pieces
    player = :B
    row_idxs = [0, 7]
    pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    row_idxs.each do |row_idx|
      player = :W if row_idx == 7

      pieces.each_with_index do |piece, idx|
        @rows[row_idx][idx] = piece.new(player, [row_idx, idx], self)
      end

    end

    (0..7).each do |idx|
      @rows[1][idx] = Pawn.new(:B, [1, idx], self)
      @rows[6][idx] = Pawn.new(:W, [6, idx], self)
    end

  end


  def self.empty_board
    Board.new
  end

  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  def render
    header = "   " + (0..7).to_a.map { |num| " #{num.to_s} " }.join
    puts header
    @rows.each_with_index do |row, r_idx|
      print " #{r_idx} "
      row.each_with_index do |cell, c_idx|
        color = (r_idx + c_idx) % 2 == 0 ? :red : :black
        print cell.render.colorize(:background => color)
      end
      puts
    end
  end

  def in_check?(player)
    king_pos =[]

    @rows.each_with_index do |row, r_idx|
      row.each_with_index do |cell, c_idx|
        king_pos = [r_idx, c_idx] if cell.king? && cell.color == player
      end
    end

    @rows.each do |row|
      row.each do |cell|
        return true if cell.is_enemy?(player) && cell.moves.include?(king_pos)
      end
    end

    false

  end

  def copy_rows
    copied_rows =[]

    @rows.each do |row|
      copied_row = []
      row.each do |cell|
        copied_row << cell.dup
      end
      copied_rows << copied_row
    end

    copied_rows
  end

  def dup
    empty_board = Board.empty_board
    empty_board.rows = self.copy_rows
    empty_board
  end

end
