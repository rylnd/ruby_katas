Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

board = Board.new
board.run!
