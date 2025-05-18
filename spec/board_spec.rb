# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    context 'when initializing a base case Board' do
      subject(:board_init) { Board.new }

      it 'has a board' do
        gameboard = board_init.gameboard
        expect(gameboard).to be_truthy
      end

      it 'has six rows' do
        gameboard = board_init.gameboard
        result = gameboard.size
        expect(result).to eql(6)
      end

      it 'has seven columns in all rows' do
        gameboard = board_init.gameboard
        result = gameboard.reduce([]) { |arr, row| arr << row.size }
        expect(result).to all(be == 7)
      end
    end

    context 'when initializing a different size Board' do
      rows = 4
      cols = 8
      subject(:board_init) { Board.new(Array.new(rows, Array.new(cols))) }

      it 'has a board' do
        gameboard = board_init.gameboard
        expect(gameboard).to be_truthy
      end

      it 'has proper number of rows' do
        gameboard = board_init.gameboard
        result = gameboard.size
        expect(result).to eql(rows)
      end

      it 'has proper number of columns in all rows' do
        gameboard = board_init.gameboard
        result = gameboard.reduce([]) { |arr, row| arr << row.size }
        expect(result).to all(be === cols)
      end
    end
  end

  describe '#spaces_left' do
    it 'returns 42 in base case' do
      board = Board.new
      result = board.spaces_left
      expect(result).to eql(42)
    end

    it 'returns product of rows and cols in empty init case' do
      rows = 4
      cols = 8
      board = Board.new(Array.new(rows, Array.new(cols)))
      result = board.spaces_left
      expect(result).to eql(rows * cols)
    end

    it 'returns the proper number of nils in midgame case' do
      board_init = [
        [nil, nil, nil],
        ['X', nil, nil],
        ['X', 'X', 'X'] # rubocop:disable Style/WordArray
      ]
      board = Board.new(board_init)
      result = board.spaces_left
      expect(result).to eql(5)
    end

    it 'returns zero when board is filled' do
      board_init = [
        ['X', 'X', 'X'], # rubocop:disable Style/WordArray
        ['X', 'X', 'X'], # rubocop:disable Style/WordArray
        ['X', 'X', 'X'] # rubocop:disable Style/WordArray
      ]
      board = Board.new(board_init)
      result = board.spaces_left
      expect(result).to be_zero
    end
  end

  describe '#place_token' do
    context 'after initializing a base case Board' do
      subject(:board) { Board.new }
      col = Array.new(7, nil)

      it 'places a token within the @board' do
        token = 'O'
        output = board.place_token(token, col)
        result = output.include?(token)
        expect(result).to be true
      end
    end
  end

  describe '#valid?' do
    it 'returns true for a simple array' do
      test = 3
      col = Array.new(6, nil)
      result = Board.new.valid?(test.to_s.ord, col)
      expect(result).to be true
    end

    it 'returns false for an empty string' do
      test = -1
      col = Array.new(6, nil)
      result = Board.new.valid?(test.to_s.ord, col)
      expect(result).to be false
    end

    it 'returns false for a full col' do
      test = 3
      col = Array.new(6, 'z')
      result = Board.new.valid?(test.to_s.ord, col)
      expect(result).to be false
    end
  end
end
