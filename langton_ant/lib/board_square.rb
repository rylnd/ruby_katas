class BoardSquare
  attr_reader :x, :y

  def initialize(x,y)
    @x, @y = x,y
    @state = BoardState.new
  end

  def color
    @state.color
  end

  def transition!
    @state.transition!
  end

  def left?
    @state.color == :black || @state.color == :blue
  end
end
