class Player
  attr_reader :name, :sign, :turn
  attr_accessor :score

  def initialize(number, x_or_o)
    @number = number.to_i
    @score = 0
    @sign = x_or_o
  end

  def now
    @turn = 'now'
  end

  def after
    @turn = 'after'
  end

  def update_turn_infos
    @turn = @turn == 'now' ? 'after' : 'now'
  end

  def init
    print "Hello player_#{@number}! Please choose your name : "
    @name = gets.chomp
  end
end
