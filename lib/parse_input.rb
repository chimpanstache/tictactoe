class ParseInput
  def initialize(user_input)
    @input = user_input.to_i
  end

  def incorrect_input?
    !@input.between?(1, 9)
  end
end
