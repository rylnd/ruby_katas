class Board
  attr_reader :steps, :size, :grid

  alias rows grid

  def initialize(options = {})
    @size = options[:size] || 20
    @steps = options[:steps] || 100
    @output = BoardOutput.new(self)
    @grid = instantiate_grid(size)

    if pattern = options[:pattern]
      self.send(pattern.to_s)
    end
  end

  def [](x)
    grid[x] || []
  end

  def run!
    begin
      steps.times do
        step
        print
      end
    ensure
      end_game
    end
  end

  def cell_at(x, y)
    grid[x][y]
  end

  def cells
    rows.flatten
  end

  def each_cell
    cells.each do |cell|
      yield(cell, cell.x, cell.y)
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
    cell.neighbors.reject do |x, y|
      x > size-1 || y > size-1
    end
  end

  def instantiate_grid(size)
    Array.new(size) do |x|
      Array.new(size) do |y|
        BoardSquare.new(x, y)
      end
    end
  end

  def step
    calculate_transitions
    transition!
  end

  def calculate_transitions
    cells.each do |cell|
      case alive_neighbors(cell)
      when 0, 1, 4..8
        cell.kill if cell.alive?
      when 3
        cell.resurrect if cell.dead?
      end
    end
  end

  def transition!
    cells.map(&:transition!)
  end

  def end_game
    @output.close
  end

  def print
    @output.print
  end

  def glider
    self[2][3].resurrect
    self[2][4].resurrect
    self[2][5].resurrect
    self[1][5].resurrect
    self[0][3].resurrect
  end

  def blinker
    self[2][3].resurrect
    self[2][4].resurrect
    self[2][5].resurrect
  end
end
