require 'rspec'
describe 'Balancer' do
  let(:subject) { Balancer.generate(count) }
  let(:count) { 1 }

  it 'works for 1' do
    subject.should =~ %w|[]|
  end

  context 'two pairs' do
    let(:count) { 2 }
    example { subject.should =~ %w|[][] [[]]| }

  end

  context 'three pairs' do
    let(:count) { 3 }
    example { subject.should =~ %w|[][][] [[]][] [][[]] [[][]] [[[]]]| }
  end
end

class Balancer
  def self.generate(count = 1)
    pairs(count)
  end

  private
  def self.pairs(count)
    return [''] if count == 0
    result = []
    for size in 0...count
      for pair in pairs(size)
        for new_pair in pairs(count-size-1)
          result << "[#{pair}]#{new_pair}"
        end
      end
    end
    result
  end
end
