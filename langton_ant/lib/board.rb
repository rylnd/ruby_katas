class Board
  attr_reader :steps

  def initialize(options = {})
    @steps = options[:steps] || 10000
    @board = instantiate_board(options[:size] || 100)
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
    File.open('output.html', 'w') do |file|
      file << BoardOutput.new(self).to_html
    end
    `open output.html`
  end
end
