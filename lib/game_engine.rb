require_relative 'parse_input'

class GameEngine
  def initialize(game, player_1, player_2)
    @game = game
    @player_1 = player_1
    @player_2 = player_2
  end


  def coin_toss
    loop do
      print "#{@player_1.name}, choose a number between 1 and 2 : "
      player_1_input = gets.chomp
      if player_1_input != "1" && player_1_input != "2"
        puts "input is invalid!"
        next
      end
      if player_1_input.to_i == Random.rand(1..2)
        puts "#{@player_1.name} plays first!"
        return 1
      else
        puts "#{@player_2.name} plays first!"
        return 2
      end
    end
  end

  def game_init
    puts "Welcome to the tic tac toe game!"
    @player_1.init 
    @player_2.init
    toss_result = 1
    toss_result = coin_toss
    if toss_result == 1
      @player_1.now
      @player_2.after
    else
      @player_1.after
      @player_2.now
    end 
    toss_result
  end

  def output_game
    puts " #{@game.grid[0][0]} | #{@game.grid[0][1]} | #{@game.grid[0][2]} " + 
    "        player | sign | turn | score"
    puts "---+---+---" + 
    "        #{@player_1.name.ljust(5).rjust(5)}|#{@player_1.sign.ljust(5).rjust(5)}| #{@player_1.turn.ljust(5).rjust(5)} | #{@player_1.score.to_s.ljust(5).rjust(5)} "
    puts " #{@game.grid[1][0]} | #{@game.grid[1][1]} | #{@game.grid[1][2]} " +
    "        #{@player_2.name.ljust(5).rjust(5)} | #{@player_2.sign.ljust(5).rjust(5)} | #{@player_2.turn.ljust(5).rjust(5)} | #{@player_2.score.to_s.ljust(5).rjust(5)} "
    puts "---+---+---"
    puts " #{@game.grid[2][0]} | #{@game.grid[2][1]} | #{@game.grid[2][2]} " +
    "        type 'exit' at anytime to exit game"
  end  

  def play(user_input)
    @turn_to_play == 1 ? @game.update_grid(user_input, @player_1.sign) : @game.update_grid(user_input, @player_2.sign)
    @turn_to_play == 1 ? @turn_to_play = 2 : @turn_to_play = 1
    @player_1.update_turn_infos
    @player_2.update_turn_infos
  end

  def game_winner
    if @game.winner == @player_1.sign
      return @player_1
    else
      return @player_2
    end
  end

  def game_loop
    @turn_to_play = game_init
    output_game
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

      play(user_input)
      output_game

      if @game.finished?
        puts "\n #### it is a draw #### \n\n"
        @game.clear_grid
        next
      end

      if @game.winner?
    
        puts "\n***** congrats #{game_winner.name} !!!! *****\n"
        game_winner.score += 1
        @game.clear_grid
        next
      end
    end
  end 
end
