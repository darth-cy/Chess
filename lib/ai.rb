class ComputerPlayer
  attr_reader :sequence_of_commands

  def initialize(color)
    @color = color
    @board = nil
    @sequence_of_commands = []
    @cursor_pos = []
  end

  def pass_board(board, highlighted_cell)
    @board = board
    @cursor_pos = highlighted_cell
    build_move if @sequence_of_commands.empty?
  end

  def get_move
    sleep(0.2)
    @sequence_of_commands.shift
  end

  def build_move

    available_pieces = @board.pieces.select { |piece| piece.is_ally?(@color)}
    available_pieces.reject! { |piece| @board.valid_moves(piece.pos).empty? }

    chosen_piece_pos = available_pieces.sample.pos
    finishing_pos = @board.valid_moves(chosen_piece_pos).sample

    @sequence_of_commands.concat(build_path(@cursor_pos, chosen_piece_pos))
    @sequence_of_commands.concat(build_path(chosen_piece_pos, finishing_pos))
  end

  def build_path(from, to)
    directions = []
    delta_x = to.first - from.first
    delta_y = to.last - from.last

    directions.concat(("w" * delta_x.abs).split("")) if delta_x < 0
    directions.concat(("s" * delta_x.abs).split("")) if delta_x > 0
    directions.concat(("a" * delta_y.abs).split("")) if delta_y < 0
    directions.concat(("d" * delta_y.abs).split("")) if delta_y > 0
    directions << "RETURN"
    directions.flatten
  end

  def require_board?
    true
  end

end
