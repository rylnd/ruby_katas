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

    it 'works for the previded examples' do
      %w|[[]
         []]
         ][][
         ][][][
         ]]][[[][
         ][]][][][[
         ][[][]]]][[[
         ]][][[[]]][][[|.each do |unbalanced|
        unbalanced.should_not be_balanced
      end

      '[][[][][[][]]][]'.should be_balanced
      '[[[[[]]][[][]]][]]'.should be_balanced
    end
  end
end

module Balancing
  def balanced?
    balance == 0
  end

  private
  def balance
    balance = 0
    self.each_char do |char|
      case char
      when '['
        balance += 1
      when ']'
        balance -= 1
      end
      return -1 if balance < 0
    end
    balance
  end
end
