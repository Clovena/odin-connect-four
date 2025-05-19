# frozen_string_literal: true

require_relative 'board'

class Game
  attr_accessor :board, :tokens

  def initialize
    @board = Board.new
    @tokens = ['🔴', '⚫']
  end

  def play
    puts @board
    turn = 0
    until game_over?
      player = turn % 2
      @board.take_turn(@tokens[player])
      puts @board
      turn += 1
    end
  end

  def game_over?
    @board.full? || winner?
  end

  def winner?
    checks = @board.gameboard + @board.gameboard.transpose
    p1_win = Array.new(4, @tokens[0])
    p2_win = Array.new(4, @tokens[1])
    checks.each do |check|
      check.each_index do |index|
        subcheck = check[index..(index + 3)]
        return true if [p1_win, p2_win].include?(subcheck)
      end
    end
    false
  end
end
