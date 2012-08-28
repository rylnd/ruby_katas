class BoardState
  STATES = [:black, :blue, :red, :yellow]

  def initialize
    @index = 0
  end

  def transition!
    @index = (@index + 1) % 4
  end

  def color
    STATES[@index]
  end
end
