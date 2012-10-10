require 'rspec'
describe 'Balancer' do
  before(:all) do
    class String
      include Balancing
    end
  end

  it 'adds a method to string' do
    ''.should respond_to(:balanced?)
  end

  context 'recognizing balanced brackets' do
    example 'opening bracket' do
      '['.should_not be_balanced
    end

    example 'closing bracket' do
      ']'.should_not be_balanced
    end

    example 'a matched pair' do
      '[]'.should be_balanced
    end

    example 'an out-of-order pair' do
      ']['.should_not be_balanced
    end
  end
end

module Balancing
  def balanced?
    Balancer.new(self).balanced?
  end

  class Balancer
    def initialize(str)
      @string = str
      @balance = 0
    end

    def balanced?
      balance_count == 0
    end

    def balance_count
      @string.each_char do |char|
        case char
        when '['
          @balance += 1
        when ']'
          @balance -= 1
          return -1 if @balance < 0
        end
      end
      @balance
    end
  end
end
