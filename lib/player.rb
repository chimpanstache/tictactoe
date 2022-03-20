class Player
  attr_reader :name, :score

  def initialize(number)
    @number = number.to_i
    @name = ""
    @battle_cry = ""
    @score = 0
  end

  def init
    print "Hello player_#{@number}! Please choose your name : "
    @name = gets.chomp
    print "Nice! Please choose your battle cry now : "
    @battle_cry = gets.chomp
  end  
end
