class Board
  attr_reader :steps, :size, :grid

  alias rows grid

  def initialize(options = {})
    @size = options[:size] || 20
    @steps = options[:steps] || 100
    @output = BoardOutput.new(self)
    @grid = instantiate_grid(size)

    pattern = options[:pattern] || :glider
    initialize_with(self.send(pattern.to_sym))
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
    [0, 3,
     1, 5,
     2, 3,
     2, 4,
     2, 5]
  end

  def blinker
    [2, 3,
     2, 4,
     2, 5]
  end

  def spaceship
    [5, 6,
     6, 5,
     7, 5,
     8, 5,
     8, 6,
     8, 7,
     8, 8,
     7, 9,
     5, 9]
  end

  def initialize_with(coordinates)
     coordinates.each_slice(2) do |x,y|
      self[x][y].resurrect
     end
  end
end
