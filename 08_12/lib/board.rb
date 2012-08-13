require_relative 'board_square.rb'
require_relative 'board_output.rb'
require_relative 'ant.rb'

class Board
  attr_accessor :board

  def initialize(size = 100)
    @size = size
    @board = instantiate_board(size)
    @ant = Ant.new(self)
  end

  def first_square
    @board[50][50]
  end

  def [](x)
    @board[x] || []
  end

  def run!
    loop { step }
  end

  private

  def instantiate_board(size)
    board = []
    size.times do |x|
      row = []
      size.times do |y|
        row << BoardSquare.new(x,y)
      end
      board << row
    end
    board
  end

  def step
    @ant.move!
    end_game if @ant.out_of_bounds
  end

  def end_game
    print
    exit
  end

  def print
    File.open('output.html', 'w') do |file|
      file << BoardOutput.new(self).to_html
    end
    `open output.html`
  end

end
