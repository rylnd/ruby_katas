class BoardSquare
  attr_reader :x, :y

  def initialize(x,y)
    @x, @y = x,y
    @value = true
  end

  def black?
    @value
  end

  def flip!
    @value = !@value
  end
end
