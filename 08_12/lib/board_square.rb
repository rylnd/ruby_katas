class BoardSquare
  attr_reader :x, :y, :color

  def initialize(x,y)
    @x = x
    @y = y
    @color = true
  end

  def flip!
    @color = !@color
  end
end
