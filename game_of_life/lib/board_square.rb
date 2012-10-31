class BoardSquare
  attr_reader :x, :y

  def initialize(x,y)
    @x, @y = x,y
    @state = BoardState.new
  end

  def color
    state.color
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
    coordinates = []
    (-1..1).each do |dx|
      (-1..1).each do |dy|
        coordinates << [x+dx, y+dy]
      end
    end
    coordinates.delete([x,y])
    coordinates
  end

  private

  def state
    @state
  end
end
