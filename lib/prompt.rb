# require 'readline'
require_relative 'game'
require_relative 'game_engine'
require_relative 'parse_input'
require_relative 'player'

player_1 = Player.new(1)
player_2 = Player.new(2)

game = Game.new(1)

engine = GameEngine.new(game, player_1, player_2)
engine.game_loop 
