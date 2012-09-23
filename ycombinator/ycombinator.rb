require 'rspec'

def y
  lambda { |f| f.call(f) }
  .call(
    lambda do |f|
      yield lambda { |*args| f.call(f).call(*args) }
    end
  )
end

describe 'YCombinator' do
  describe 'factorial' do

    let(:almost_factorial) do
      lambda do |function|
        lambda do |n|
          if n == 0
            1
          else
            n * function.call(n-1)
          end
        end
      end
    end

    def factorial(n)
      y(&almost_factorial).call(n)
    end

    it 'should calculate factorial(0)' do
      factorial(0).should == 1
    end

    it 'should calculate factorial(2)' do
      factorial(2).should == 2
    end

    it 'should calculate factorial(3)' do
      factorial(3).should == 6
    end
  end
end
