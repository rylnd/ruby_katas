require 'rubygems'
require 'bundler/setup'

Bundler.require

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

10.times do |i|
  steps = (i+1) * 10_000
  Board.new(:steps => steps, :filename => "#{i}.png").run!
end
