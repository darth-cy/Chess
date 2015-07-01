require "colorize"
require 'byebug'
require_relative 'allpiece'

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

  def valid?(move)
    move.all? { |el| el.between?(0, 7) }
  end

  def valid_moves(pos)
    self[pos].moves.map do |to|
      self.dup.move(pos, to).in_check?(self[pos].color) ? nil : to
    end.compact
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

  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @rows[row][col] = mark
  end

  def in_check?(player)
    king_pos = []

    pieces.each do |piece|
      king_pos = piece.pos if piece.king? && piece.is_ally?(player)
    end

    pieces.each do |piece|
      return true if piece.is_enemy?(player) && piece.moves.include?(king_pos)
    end

    false
  end

  def pieces

    @rows.flatten.select { |piece| !piece.pos.nil?}

  end

  def dup
    empty_board = Board.new

    pieces.each do |piece|
      empty_board[piece.pos] = piece.dup(empty_board)
    end

    empty_board
  end

  def checkmate?(player)
    all_pos = pieces.select { |piece| piece.is_ally?(player) }
                    .map { |piece| piece.pos }
    all_pos.all? { |pos| valid_moves(pos).empty? }
  end

  def move(from, to)
    if self[to].is_enemy?(from)
      self[to] = EmptyPiece.new
    end

    self[from].has_moved if self[from].is_pawn?

    self[from].change_pos(to)
    self[to], self[from] = self[from], self[to]

    self
  end
end
