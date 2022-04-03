require_relative '../lib/game'
require_relative 'spec_helper'

describe Game do
  describe '#winner?' do
    context 'when there is a winner on first line' do
      game = Game.new(1)
      game.grid = [%w[O O O], [4, 5, 6], [7, 8, 9]]
      it 'returns true' do
        expect(game.winner?).to be_truthy
      end
    end
    context 'when there is a winner on second line' do
      game = Game.new(1)
      game.grid = [[1, 2, 3], %w[X X X], [7, 8, 9]]
      it 'returns true' do
        expect(game.winner?).to be_truthy
      end
    end
    context 'when there is a winner on third line' do
      game = Game.new(1)
      game.grid = [[1, 2, 3], ['O', 'O', 6], %w[X X X]]
      it 'returns true' do
        expect(game.winner?).to be_truthy
      end
    end
    context 'when there is a winner on first column' do
      game = Game.new(1)
      game.grid = [['O', 2, 3], ['O', 5, 6], ['O', 8, 9]]
      it 'returns true' do
        expect(game.winner?).to be_truthy
      end
    end
    context 'when there is a winner on second column' do
      game = Game.new(1)
      game.grid = [[1, 'O', 3], [4, 'O', 6], [7, 'O', 9]]
      it 'returns true' do
        expect(game.winner?).to be_truthy
      end
    end

    context 'when there is a winner on third column' do
      game = Game.new(1)
      game.grid = [[1, 2, 'O'], [4, 5, 'O'], [7, 8, 'O']]
      it 'returns true' do
        expect(game.winner?).to be_truthy
      end
    end

    context 'when there is a winner on first diagonal' do
      game = Game.new(1)
      game.grid = [['O', 2, 3], [4, 'O', 6], [7, 8, 'O']]
      it 'returns true' do
        expect(game.winner?).to be_truthy
      end
    end

    context 'when there is a winner on second diagonal' do
      game = Game.new(1)
      game.grid = [[1, 2, 'O'], [4, 'O', 6], ['O', 8, 9]]
      it 'returns true' do
        expect(game.winner?).to be_truthy
      end
    end
  end

  describe '#finished?' do
    context 'when the game is not finished' do
      game = Game.new(1)
      game.grid = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
      it 'returns false' do
        expect(game.finished?).to be_falsy
      end
    end

    context 'when the game is almost finished' do
      game = Game.new(1)
      game.grid = [%w[O X O], %w[X O X], ['O', 'X', 9]]
      it 'returns false' do
        expect(game.finished?).to be_falsy
      end
    end

    context 'when there is a draw' do
      game = Game.new(1)
      game.grid = [%w[O X O], %w[X O X], %w[O X X]]
      it 'returns true' do
        expect(game.finished?).to be_truthy
      end
    end
  end

  describe '#already_played?' do
    context 'when the box is already played' do
      game = Game.new(1)
      game.grid = [['O', 2, 3], [4, 5, 6], [7, 8, 9]]
      it 'returns true' do
        expect(game.already_played?(1)).to be_truthy
      end
    end
    
    context 'when the box is not already played' do
      game = Game.new(1)
      game.grid = [['O', 2, 3], [4, 5, 6], [7, 8, 9]]
      it 'returns false' do
        expect(game.already_played?(2)).to be_falsy
      end
    end
  end
end
