require_relative 'board_square.rb'
require_relative 'board_output.rb'
require_relative 'ant.rb'

class Board
  attr_accessor :board

  def initialize(size = 100)
    @board = instantiate_board(size)
    @ant = Ant.new(self)
  end

  def [](x)
    @board[x] || []
  end

  def run!
    loop { step }
  end

  private

  def instantiate_board(size)
    Array.new(size) do |x|
      Array.new(size) do |y|
        BoardSquare.new(x,y)
      end
    end
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
