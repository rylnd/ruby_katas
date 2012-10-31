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

  def each_cell
    rows.each_with_index do |row, x|
      row.each_with_index do |cell, y|
        yield(cell, x, y)
      end
    end
  end

  private

  def alive_neighbors(x,y)
    neighbors = valid_neighbors(x,y)

    neighbors.reduce(0) do |sum, pair|
      nx, ny = pair
      neighbor = self[nx][ny]
      neighbor.alive? ? sum + 1 : sum
    end
  end

  def valid_neighbors(x,y)
    self[x][y].neighbors.reject do |x,y|
      x < 0 || x > @size-1 || y < 0 || y > @size-1
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
    each_cell do |cell, x, y|
      case alive_neighbors(x,y)
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
