require_relative 'board'

class MasterBoard < Board
  CURSOR_DIRECTIONS = ['w', 's', 'a', 'd']

  def initialize
    @rows = Array.new(8) { Array.new(8) { EmptyPiece.new } }
    set_pieces
    @highlighted_cell = [4,4]
    @reachable = []
    @selected = nil
    @moved = false
  end

  def render
    system "clear"
    header = "   " + ("a".."h").to_a.map { |letter| " #{letter} " }.join
    puts header
    @rows.each_with_index do |row, r_idx|
      print " #{8 - r_idx} "
      row.each_with_index do |cell, c_idx|
        color = (r_idx + c_idx) % 2 == 0 ? :red : :black
        color = :yellow if @highlighted_cell == [r_idx, c_idx]
        color = :white if @reachable.include?([r_idx, c_idx])
        color = :blue if @selected == [r_idx, c_idx]
        print cell.render.colorize(:background => color)
      end
      puts
    end
  end

  def read_command(player, command)
    move_around(player, command)
    select_cell(player, command)
  end

  def move_around(player, command)
    return unless CURSOR_DIRECTIONS.include?(command)
    case command
    when 'w'
      move = [@highlighted_cell.first - 1, @highlighted_cell.last]
      @highlighted_cell = move if valid?(move)
    when 's'
      move = [@highlighted_cell.first + 1, @highlighted_cell.last]
      @highlighted_cell = move if valid?(move)
    when 'a'
      move = [@highlighted_cell.first, @highlighted_cell.last - 1]
      @highlighted_cell = move if valid?(move)
    when 'd'
      move = [@highlighted_cell.first, @highlighted_cell.last + 1]
      @highlighted_cell = move if valid?(move)
    end
    recalculate(player)
  end

  def recalculate(player)
    return [] if self[@highlighted_cell].is_enemy?(player)
    @reachable = self.valid_moves(@highlighted_cell)
  end

  def select_cell(player, command)
    return unless command == "RETURN"

    if @selected.nil? && self[@highlighted_cell].is_ally?(player)
      @selected = @highlighted_cell
    elsif !@selected.nil? && self.valid_moves(@selected).include?(@highlighted_cell)
      @moved = true if move(@selected, @highlighted_cell)
      @selected = nil
    else
      @selected = nil
    end

  end

  def to_move
    @moved = false
  end

  def moved?
    @moved
  end

end
