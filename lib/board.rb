class Board
  attr_accessor :gameboard

  def initialize(gameboard = Array.new(6, Array.new(7)))
    @gameboard = gameboard
  end

  def spaces_left(matrix = @gameboard)
    matrix.flatten.count(nil)
  end

  def place_token(token, col)
    working_gameboard = @gameboard.reverse.transpose
    working_row = working_gameboard[col]
    working_row.each_with_index do |space, index|
      next unless space.nil?
      working_row[index] = token
    end
    @gameboard = working_gameboard.transpose.reverse
  end
end
