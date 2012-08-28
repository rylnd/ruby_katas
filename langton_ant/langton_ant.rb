Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

10.times do |i|
  steps = (i+1) * 10_000
  Board.new(:steps => steps).run!
end
