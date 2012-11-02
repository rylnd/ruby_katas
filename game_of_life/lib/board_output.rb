require 'curses'

class BoardOutput
  attr_reader :window

  def initialize(board, options={})
    @board = board
    @window = new_window
  end

  def print
    update_window
    window.refresh
    sleep 0.1
  end

  def close
    Curses.close_screen
  end

  private

  def new_window
    size = @board.size + 2
    win = Curses::Window.new(size, size, 0, 0)
    win.box(?|, ?-)
    win
  end

  def update_window
    @board.each_cell do |cell, x, y|
      window.setpos(x+1, y+1)
      window.addstr(cell.char)
    end
  end
end
