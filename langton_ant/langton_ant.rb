require 'rubygems'
require 'bundler/setup'

Bundler.require
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

include Magick

20.times do |i|
  steps = (i+1) * 5_000
  Board.new(:steps => steps, :filename => "#{i}.png").run!
end

slides = Dir['output/*.png'].sort_by do |f|
  f.gsub('output/', '').split('.')[0].to_i
end
animation = ImageList.new(*slides)
animation.delay = 10
animation.write("output/output.gif")
