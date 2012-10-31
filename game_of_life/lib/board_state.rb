class BoardState
  attr_accessor :alive

  def initialize
    @alive = false
  end

  def transition!(next_state)
    @alive = next_state unless next_state.nil?
  end

  def color
    @alive ? :white : :black
  end
end
