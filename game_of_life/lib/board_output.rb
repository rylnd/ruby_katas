class BoardOutput
  attr_reader :filename

  def initialize(board, options={})
    @board = board
    @filename = options[:filename] || 'output.png'
    generate_image
    save_image
  end

  private

  def generate_image
    @image = ChunkyPNG::Image.new(@board.size, @board.size)

    @board.each_cell do |cell, x, y|
      @image[x,y] = ChunkyPNG::Color(cell.color)
    end
  end

  def save_image
    @image.save("output/#{@filename}")
  end
end
