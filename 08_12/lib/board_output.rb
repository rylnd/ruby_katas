class BoardOutput
  def initialize(board)
    @board = board
    @page = ''
  end

  def color(square)
    square.color ? 'black' : 'white'
  end

  def to_html
    generate_page
    @page
  end

  private
  def generate_page
    @board.board.each do |row|
      @page << "<div style='clear:left'></div>\n"
      row.each do |square|
        @page << %Q|<div style="float:left;height:10px;width:10px;background-color:#{color(square)}"></div>\n|
      end
    end
  end
end
