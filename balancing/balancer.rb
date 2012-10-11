require 'rspec'
describe 'Balancer' do
  let(:subject) { Balancer.generate(count, options) }
  let(:options) { {} }
  let(:count) { 1 }

  context 'one pair' do
    example { should =~ %w|[]| }
  end

  context 'two pairs' do
    let(:count) { 2 }
    example { should =~ %w|[][] [[]]| }
  end

  context 'three pairs' do
    let(:count) { 3 }
    example { should =~ %w|[][][] [[]][] [][[]] [[][]] [[[]]]| }
  end

  context 'optional open/close' do
    let(:options) { { open: '(', close: ')' } }
    example { should =~ %w|()| }
  end
end

class Balancer
  DEFAULT_OPTIONS = { open: '[', close: ']' } unless const_defined? :DEFAULT_OPTIONS

  def self.generate(count = 1, options = {})
    options = DEFAULT_OPTIONS.merge(options)
    pairs(count, options)
  end

  private
  def self.pairs(count, options)
    return [''] if count == 0
    result = []
    for size in 0...count
      for pair in pairs(size, options)
        for new_pair in pairs(count-size-1, options)
          result << options[:open] + pair + options[:close] + new_pair
        end
      end
    end
    result
  end
end
