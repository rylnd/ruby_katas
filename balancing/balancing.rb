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

  it 'works for parens' do
    ')('.should_not be_balanced
    '()'.should be_balanced
  end

  it 'works for braces' do
    '}{'.should_not be_balanced
    '{}'.should be_balanced
  end

  it 'works for angle brackets' do
    '><'.should_not be_balanced
    '<>'.should be_balanced
  end

  it 'works for single quotes' do
    %q|'|.should_not be_balanced
    %q|''|.should be_balanced
    %q|'''|.should_not be_balanced
    %q|''''|.should be_balanced
  end

  it 'works for double quotes' do
    %q|"|.should_not be_balanced
    %q|""|.should be_balanced
    %q|"""|.should_not be_balanced
    %q|""""|.should be_balanced
  end
end

module Balancing
  def balanced?
    balance == 0
  end

  private
  def balance
    return quote_balance if %w|' "|.include? first_char
    return -1 unless open

    pair_balance
  end

  def pair_balance
    balance = 0
    self.each_char do |char|
      case char
      when open
        balance += 1
      when close
        balance -= 1
      end
      break if balance < 0
    end
    balance
  end

  def quote_balance
    self.scan(first_char).size % 2
  end

  def character_pair
    {
      '(' => %w|( )|,
      '[' => %w|[ ]|,
      '<' => %w|< >|,
      '{' => %w|{ }|,
    }[first_char] || []
  end

  def first_char
    @first_char ||= self[0]
  end

  def open
    @open ||= character_pair[0]
  end

  def close
    @close ||= character_pair[1]
  end
end
