class Game
  attr_accessor :grid, :winner

  def initialize(_number)
    @grid = Array.new(3) { Array.new(3) { 0 } }
    clear_grid
    @x_or_o = 'O'
  end

  def clear_grid
    box = 1

    (0..2).each do |i|
      (0..2).each do |j|
        @grid[i][j] = box
        box += 1
      end
    end
  end

  def update_x_or_o
    case @x_or_o
    when 'X'
      @x_or_o = 'O'
    when 'O'
      @x_or_o = 'X'
    end
  end

  def update_grid(user_input, sign)
    box = user_input.to_i
    (0..2).each do |x|
      (0..2).each do |y|
        @grid[x][y] = sign if @grid[x][y] == box
      end
    end
    update_x_or_o
  end

  def already_played?(user_input)
    box = user_input.to_i
    (0..2).each do |x|
      (0..2).each do |y|
        return false if @grid[x][y] == box
      end
    end
    true
  end

  def finished?
    (0..2).each do |x|
      (0..2).each do |y|
        return false if @grid[x][y].to_i.between?(1, 9)
      end
    end
    true
  end

  def three_same_values?(arr)
    @winner = arr.uniq.first
    arr.uniq.length == 1
  end

  def winning_via_row?
    (0..2).each do |x|
      row = Array.new(3)
      (0..2).each do |y|
        row[y] = @grid[x][y]
      end
      return true if three_same_values?(row)
    end
    false
  end

  def winning_via_column?
    (0..2).each do |y|
      column = Array.new(3)
      (0..2).each do |x|
        column[x] = @grid[x][y]
      end
      return true if three_same_values?(column)
    end
    false
  end

  def winning_via_diagonal?
    diag = []
    (0..2).each do |i|
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
