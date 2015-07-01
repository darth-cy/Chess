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
    header = "   " + (0..7).to_a.map { |num| " #{num.to_s} " }.join
    puts header
    @rows.each_with_index do |row, r_idx|
      print " #{r_idx} "
      row.each_with_index do |cell, c_idx|
        color = (r_idx + c_idx) % 2 == 0 ? :red : :black
        color = :yellow if @highlighted_cell == [r_idx, c_idx]
        color = :white if @reachable.include?([r_idx, c_idx])
        print cell.render.colorize(:background => color)
      end
      puts
    end
  end

  def read_command(command)
    puts "in read_command"
    move_around(command)
    select_cell(command)
  end

  def move_around(command)
    puts "in move_around"
    return unless CURSOR_DIRECTIONS.include?(command)
    puts command
    case command
    when 'w'
      move = [@highlighted_cell.first - 1, @highlighted_cell.last]
      @highlighted_cell = move if valid?(move)
    when 's'
      move = [@highlighted_cell.first + 1, @highlighted_cell.last]
      @highlighted_cell = move if valid?(move)
    when 'a'
      move = [@highlighted_cell.first, @highlighted_cell.last - 1]
      p move
      @highlighted_cell = move if valid?(move)
    when 'd'
      move = [@highlighted_cell.first, @highlighted_cell.last + 1]
      @highlighted_cell = move if valid?(move)
    end
    recalculate
  end

  def recalculate
    @reachable = self[@highlighted_cell].moves
  end

  def select_cell(command)
    return unless command == "RETURN"

    if @selected.nil?
      @selected = @highlighted_cell
    elsif !@selected.nil? && @reachable.include?(@highlighted_cell)
      @moved = true if move(@selected, @highlighted_cell)
    end

  end

  def to_move
    @moved = false
  end

  def moved?
    @moved
  end

end
