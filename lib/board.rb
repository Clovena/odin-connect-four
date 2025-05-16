# frozen_string_literal: true

class Board
  attr_accessor :gameboard, :rows

  def initialize(gameboard = Array.new(6, Array.new(7)))
    @gameboard = gameboard
    @rows = gameboard.size
  end

  def spaces_left(matrix = @gameboard)
    matrix.flatten.count(nil)
  end

  def place_token(token, col = rand(0..@rows))
    working_gameboard = @gameboard.reverse.transpose
    working_col = working_gameboard[col]
    return unless valid?(working_col)

    working_col.each_with_index do |space, index|
      if space.nil?
        working_col[index] = token
        break
      end
    end
    @gameboard = working_gameboard.transpose.reverse
  end

  # #place_token helper methods
  def valid?(col)
    return true unless col.nil? || !col.include?(nil)
    false
  end
end
