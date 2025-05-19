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
    @board.empty? || winner?
  end

  def winner?
    false
  end
end
