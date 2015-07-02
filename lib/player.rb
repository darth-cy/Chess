require_relative 'keypress'

class Player
  include Keypress

  def initialize
  end

  def get_move
    read_single_key
  end

  def require_board?
    false
  end

end
