require 'rspec'

def y
  lambda { |f| f.(f) }
  .(
    lambda do |f|
      yield lambda { |*args| f.(f).(*args) }
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
            n * function.(n-1)
          end
        end
      end
    end

    def factorial(n)
      y(&almost_factorial).(n)
    end

    [1, 1, 2, 6, 24, 120, 720]
    .each_with_index do |expected, i|
      it "calculates #{i}!" do
        factorial(i).should == expected
      end
    end
  end

  describe 'fibonacci' do
    let(:almost_fibonacci) do
      lambda do |function|
        lambda do |n|
          case n
          when 0, 1
            n
          else
            function.(n-1) + function.(n-2)
          end
        end
      end
    end

    def fibonacci(n)
      y(&almost_fibonacci).(n)
    end

    [0, 1, 1, 2, 3, 5, 8, 13]
    .each_with_index do |expected, i|
      it "calculates fibonacci(#{i})" do
        fibonacci(i).should == expected
      end
    end
  end
end
