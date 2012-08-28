class Board
  attr_reader :steps, :size

  def initialize(options = {})
    @size = options[:size] || 100
    @steps = options[:steps] || 10_000
    @filename = options[:filename] || "#{@steps}_steps.png"
    @board = instantiate_board(@size)
    @ant = Ant.new(self)
  end

  def [](x)
    @board[x] || []
  end

  def rows
    @board
  end

  def run!
    @steps.times { step }
    end_game
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
  end

  def print
    BoardOutput.new(self, filename: @filename)
  end
end
