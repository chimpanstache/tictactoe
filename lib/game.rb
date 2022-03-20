class Game
  attr_reader :grid, :winner

  def initialize(number)
    @grid = Array.new(3) { Array.new(3) {0} } 
    
    clear_grid

    @x_or_o = 'O'
    @winner = ''
  end             

  def clear_grid
    box = 1

    for i in 0..2 do
      for j in 0..2 do
        @grid[i][j] = box
        box += 1
      end
    end
  end  

  def update_x_or_o
    if @x_or_o == 'X'
      @x_or_o = 'O'
    elsif @x_or_o == 'O'
      @x_or_o = 'X'
    end
  end  

  def update_grid(user_input, sign)
    box = user_input.to_i
    for x in 0..2 do
      for y in 0..2 do
        @grid[x][y] = sign if @grid[x][y] == box    
      end
    end
    update_x_or_o
  end

  def already_played?(user_input)
    box = user_input.to_i
    for x in 0..2 do
      for y in 0..2 do
        return false if @grid[x][y] == box
      end
    end
    true
  end

  def finished?
    for x in 0..2 do
      for y in 0..2 do
        return false if @grid[x][y].to_i.between?(1, 9)  
      end
    end
    true
  end

  def three_same_values?(arr)
    @winner = arr.uniq
    arr.uniq.length == 1
  end
  
  def winning_via_row?
    for x in 0..2 do
      row = Array.new(3)
      for y in 0..2 do
        row[y] = @grid[x][y]
      end
      return true if three_same_values?(row)  
    end
    false
  end

  def winning_via_column?
    for y in 0..2 do
      column = Array.new(3)
      for x in 0..2 do
        column[x] = @grid[x][y]
      end
      return true if three_same_values?(column)  
    end
    false
  end

  def winning_via_diagonal?
    diag = []
    for i in 0..2 do
      diag.push(@grid[i][i])
    end
    return true if three_same_values?(diag)

    diag.clear

    diag.push(@grid[2][0])
    diag.push(@grid[1][1])
    diag.push(@grid[0][2])
    return true if three_same_values?(diag)
    false
  end

  def winner?
    winning_via_row? || winning_via_column? || winning_via_diagonal?
  end
end
