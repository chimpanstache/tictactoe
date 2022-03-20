require_relative 'parse_input'

class GameEngine
  def initialize(game, player_1, player_2)
    @game = game
    @player_1 = player_1
    @player_2 = player_2
  end

  def game_init
    puts "Welcome to the tic tac toe game!"
    @player_1.init 
    @player_2.init
    output_game
  end

  def output_game
    puts " #{@game.grid[0][0]} | #{@game.grid[0][1]} | #{@game.grid[0][2]} " + 
    "        #{@player_1.name}'s score : #{@player_1.score}"
    puts "---+---+---" + 
    "        #{@player_2.name}'s score : #{@player_2.score}"
    puts " #{@game.grid[1][0]} | #{@game.grid[1][1]} | #{@game.grid[1][2]} "
    puts "---+---+---" +
    "        type 'exit' at anytime to exit game"
    puts " #{@game.grid[2][0]} | #{@game.grid[2][1]} | #{@game.grid[2][2]} "
  end  

  def game_loop
    game_init
    loop do

      user_input = gets.chomp
      
      if user_input == "exit"   
        puts "See you later!"
        break
      end

      parse = ParseInput.new(user_input)

      if parse.incorrect_input?
        puts "\n #### input is invalid, type a number between 1 and 9 #### \n\n"
        output_game
        next
      end

      if @game.already_played?(user_input)
        puts "\n #### already played, choose a different box #### \n\n"
        output_game
        next
      end  

      @game.update_grid(user_input)

      output_game

      if @game.finished?
        puts "\n #### it is a draw #### \n\n"
        break
      end

      if @game.winner?
        puts "\n***** congrats champ !!!! *****\n"
        break
      end
    end
  end 
end
