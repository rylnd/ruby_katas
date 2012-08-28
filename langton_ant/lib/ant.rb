class Ant
  def initialize(board)
    @board = board
    @square = @board[50][50]
    @dir = 1
  end

  def move!
    @square.left? ? turn_left! : turn_right!
    @square.transition!
    move_forward!
  end

  def turn_right!
    @dir = (@dir + 1) % 4
  end

  def turn_left!
    @dir = (@dir - 1) % 4
  end

  def move_forward!
    x, y = @square.x, @square.y

    @square = { 0 => @board[x][y+1],
                1 => @board[x+1][y],
                2 => @board[x][y-1],
                3 => @board[x-1][y],
              }[@dir]
  end

  def out_of_bounds
    !@square
  end
end
