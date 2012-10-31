class Board
  attr_reader :steps, :size

  def initialize(options = {})
    @size = options[:size] || 20
    @steps = options[:steps] || 100
    @filename = options[:filename] || "#{@steps}_steps.png"
    @board = instantiate_board(@size)
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

  def cell_at(x,y)
    @board[x][y]
  end

  def each_cell
    rows.each_with_index do |row, x|
      row.each_with_index do |cell, y|
        yield(cell, x, y)
      end
    end
  end

  private

  def alive_neighbors(cell)
    valid_neighbors(cell).reduce(0) do |sum, pair|
      neighbor = cell_at(*pair)
      neighbor.alive? ? sum + 1 : sum
    end
  end

  def valid_neighbors(cell)
    cell.neighbors.reject do |x,y|
       x > @size-1 || y > @size-1
    end
  end

  def instantiate_board(size)
    Array.new(size) do |x|
      Array.new(size) do |y|
        BoardSquare.new(x,y)
      end
    end
  end

  def step
    each_cell do |cell|
      case alive_neighbors(cell)
      when 0, 1, 4..8
        cell.kill if cell.alive?
      when 3
        cell.resurrect if cell.dead?
      end
    end
    step!
  end

  def step!
    each_cell { |cell| cell.transition! }
  end

  def end_game
    print
  end

  def print
    BoardOutput.new(self, filename: @filename)
  end
end
