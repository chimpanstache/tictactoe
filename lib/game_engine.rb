require_relative 'parse_input'
require 'byebug'

class GameEngine
  def initialize(game, player1, player2)
    @game = game
    @player1 = player1
    @player2 = player2
  end

  def coin_toss
    loop do
      print "#{@player1.name}, choose a number between 1 and 2 : "
      player1_input = gets.chomp
      if player1_input != '1' && player1_input != '2'
        puts 'input is invalid!'
        next
      end
      if player1_input.to_i == Random.rand(1..2)
        puts "#{@player1.name} plays first!"
        return 1
      else
        puts "#{@player2.name} plays first!"
        return 2
      end
    end
  end

  def game_init
    puts 'Welcome to the tic tac toe game!'
    @player1.init
    @player2.init
    toss_result = coin_toss
    if toss_result == 1
      @player1.now
      @player2.after
    else
      @player1.after
      @player2.now
    end
    toss_result
  end

  def output_info_board
    '        players   | sign  | turn  | score'
  end

  def format_name(name)
    name.ljust(10).to_s
  end

  def format_info(info)
    info.ljust(6).to_s
  end

  def output_player_infos(player)
    '       ' +
      format_name(player.name) + '| ' +
      format_info(player.sign) + '| ' +
      format_info(player.turn) + '| ' +
      format_info(player.score.to_s)
  end

  def output_game
    puts ' ' + @game.grid[0][0].to_s + ' | ' + @game.grid[0][1].to_s + ' | ' + @game.grid[0][2].to_s +
         output_info_board
    puts '---+---+---' + output_player_infos(@player1)
    puts ' ' + @game.grid[1][0].to_s + ' | ' + @game.grid[1][1].to_s + ' | ' + @game.grid[1][2].to_s +
         ' ' + output_player_infos(@player2)
    puts '---+---+---'
    puts ' ' + @game.grid[2][0].to_s + ' | ' + @game.grid[2][1].to_s + ' | ' + @game.grid[2][2].to_s + ' ' +
         "        type 'exit' at anytime to exit game"
  end

  def play(user_input)
    @turn_to_play == 1 ? @game.update_grid(user_input, @player1.sign) : @game.update_grid(user_input, @player2.sign)
    @turn_to_play = @turn_to_play == 1 ? 2 : 1
    @player1.update_turn_infos
    @player2.update_turn_infos
  end

  def game_winner
    return @player1 if @game.winner == @player1.sign

    @player2
  end

  def wrong_action(display_message)
    puts display_message
    output_game
  end

  def winning_calculations
    puts "\n***** congrats #{game_winner.name} !!!! *****\n"
    next_player = @player1.turn == 'now' ? @player1 : @player2
    puts "  ** #{next_player.name} starts the next game, please make first move **\n"
    game_winner.score += 1
    @game.clear_grid
  end

  def draw
    puts "\n #### it is a draw #### \n\n"
    @game.clear_grid
  end

  def game_loop
    @turn_to_play = game_init
    output_game
    loop do
      print 'move: '
      user_input = gets.chomp

      if user_input == 'exit'
        puts 'See you later!'
        break
      end

      clean_input = ParseInput.new(user_input)

      if clean_input.incorrect_input?
        wrong_action("\n #### input is invalid, type a number between 1 and 9 #### \n\n")
        next
      elsif @game.already_played?(user_input)
        wrong_action("\n #### already played, choose a different box #### \n\n")
        next
      end

      play(user_input)
      output_game

      if @game.finished?
        draw
        next
      end

      next unless @game.winner?

      winning_calculations
      next
    end
  end
end
