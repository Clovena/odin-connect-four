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
        expect(result).to all(be === 7)
      end
    end

    context 'when initializing a different size Board' do
      rows = 4
      cols = 8
      subject(:board_init) { Board.new( Array.new(rows, Array.new(cols)) ) }
      
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
      board = Board.new( Array.new(rows, Array.new(cols)) )
      result = board.spaces_left
      expect(result).to eql(rows * cols)
    end

    it 'returns the proper number of nils in midgame case' do
      board_init = [
        [nil, nil, nil],
        ['X', nil, nil],
        ['X', 'X', 'X']
      ]
      board = Board.new(board_init)
      result = board.spaces_left
      expect(result).to eql(5)
    end

    it 'returns zero when board is filled' do
      board_init = [
        ['X', 'X', 'X'],
        ['X', 'X', 'X'],
        ['X', 'X', 'X']
      ]
      board = Board.new(board_init)
      result = board.spaces_left
      expect(result).to be_zero
    end
  end

  describe '#place_token' do
    context 'after initializing a base case Board' do
      subject(:board) { Board.new }

      it 'places a token within the @board' do
        token = 'O'
        board.place_token(token, rand(1..7))
        gameboard = board.gameboard
        result = gameboard.flatten.include? token
        expect(result).to be true
      end
    end
  end
end