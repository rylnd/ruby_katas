class BoardOutput
  def initialize(board)
    @board = board
    @page = ''
  end

  def to_html
    generate_page
    @page
  end

  private
  def generate_page
    @page << "<h2>Ran #{@board.steps} times</h2>\n"
    @board.rows.each do |row|
      @page << "<div style='clear:left'></div>\n"
      row.each do |square|
        @page << %Q|<div style="float:left;height:10px;width:10px;background-color:#{square.color}"></div>\n|
      end
    end
  end
end
