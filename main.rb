# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/board'

game = Game.new
puts game.board.spaces_left
game.play
