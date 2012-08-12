require_relative 'board_square.rb'

class Ant
  attr_accessor :square, :dir

  def initialize(board)
    puts "Ant inited with '#{board}'"
    @board = board
    @square = @board.first_square
    @dir = [0,1,2,3].shuffle.first
  end

  def move!
    @square.color ? turn_left! : turn_right!
    @square.flip!
    move_forward!
  end

  def turn_right!
    @dir = (@dir + 1) % 4
  end

  def turn_left!
    @dir = (@dir - 1) % 4
  end

  def move_forward!
    x,y = @square.x, @square.y
    @square = case @dir
              when 0
                @board[x][y+1]
              when 1
                @board[x+1][y]
              when 2
                @board[x][y-1]
              when 3
                @board[x-1][y]
              end
  end

  def out_of_bounds
    !@square
  end
end
