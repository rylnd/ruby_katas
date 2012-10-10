require 'rspec'
describe 'Balancer' do
  before(:all) do
    class String
      include Balancer
    end
  end

  it 'adds a method to string' do
    "[[]]".should respond_to(:balanced?)
  end
end

module Balancer
  def balanced?
  end
end
