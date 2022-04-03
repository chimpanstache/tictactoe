require_relative '../lib/player'
require_relative 'spec_helper'

describe Player do
  describe '#update_turn_infos' do
    context "when turn is \'now\'" do
      player = Player.new(1, 'X')
      player.now

      it "updates turn to \'after\'" do
        expect(player.update_turn_infos).to eq('after')
      end
    end
    context "when turn is \'now\'" do
      player = Player.new(1, 'X')
      player.after

      it "updates turn to \'after\'" do
        expect(player.update_turn_infos).to eq('now')
      end
    end
  end
end
