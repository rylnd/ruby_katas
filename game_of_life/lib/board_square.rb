class BoardSquare
  attr_reader :x, :y, :state

  def initialize(x,y)
    @x, @y = x, y
    @state = BoardState.new
  end

  def char
    state.char
  end

  def transition!
    state.transition!(@next_state)
  end

  def kill
    @next_state = false
  end

  def resurrect
    @next_state = true
  end

  def alive?
    state.alive
  end

  def dead?
    !state.alive
  end

  def neighbors
    possible_neighbors.reject { |x, y| x < 0 || y < 0 }
  end

  private

  def possible_neighbors
    (-1..1).reduce([]) do |pairs, dx|
      (-1..1).each { |dy| pairs << [x+dx, y+dy] }
      pairs - [[x,y]]
    end
  end
end
