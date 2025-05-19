# frozen_string_literal: true

# Methods to manipulate the game board
class Board
  BASE_COL = '0'.ord

  attr_accessor :gameboard, :rows

  def initialize(gameboard = Array.new(6) { Array.new(7) })
    @gameboard = gameboard
    @rows = gameboard.size
  end

  def to_s
    @gameboard.each do |row|
      p row
    end
  end

  def spaces_left(matrix = @gameboard)
    matrix.flatten.count(nil)
  end

  def full?
    spaces_left.zero?
  end

  def take_turn(token)
    working_gameboard = @gameboard.reverse.transpose
    puts 'Please drop your token into a column: '
    col = input_col(working_gameboard)
    placed = place_token(token, working_gameboard[col])
    working_gameboard[col] = placed
    @gameboard = working_gameboard.transpose.reverse
  end

  def input_col(board)
    col_hash = format_col
    until valid?(col_hash[:col_ord], board[col_hash[:col_num]])
      puts 'Invalid selection. Please drop your token into a column: '
      col_hash = format_col
    end
    col_hash[:col_num]
  end

  def format_col
    input = gets.chomp[0]
    input_ord = (input.nil? ? -1 : input).ord
    {
      col_ord: input_ord,
      col_num: input_ord.to_i - BASE_COL
    }
  end

  def valid?(col, working_col)
    return false unless col.between?(BASE_COL, @rows.to_s.ord)
    return false if col == ''
    return false if working_col.nil?
    return false unless working_col.include?(nil)

    true
  end

  def place_token(token, col)
    col.each_with_index do |space, index|
      if space.nil?
        col[index] = token
        break
      end
    end
    col
  end
end
