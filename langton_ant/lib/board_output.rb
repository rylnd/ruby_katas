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

    @board.rows.each_with_index do |row, x|
      row.each_with_index do |square, y|
        @image[x,y] = ChunkyPNG::Color(square.color)
      end
    end
  end

  def save_image
    Dir.mkdir('output') unless Dir.exist?('output')
    @image.save("output/#{@filename}")
  end
end
