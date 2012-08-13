module IntToEn
  ONES =  { '0' => '', '1' => 'one ', '2' => 'two ', '3' => 'three ',
            '4' => 'four ', '5' => 'five ', '6' => 'six ',
            '7' => 'seven ', '8' => 'eight ', '9' => 'nine ' }
  TEENS = { '10' => 'ten ', '11' => 'eleven ',
            '12' => 'twelve ', '13' => 'thirteen ', '14' => 'fourteen ',
            '15' => 'fifteen ', '16' => 'sixteen ', '17' => 'seventeen ',
            '18' => 'eightteen ', '19' => 'nineteen ' }
  TENS =  { '0' => '', '2' => 'twenty ', '3' => 'thirty ',
            '4' => 'forty ', '5' => 'fifty ', '6' => 'sixty ',
            '7' => 'seventy ', '8' => 'eighty ', '9' => 'ninety ' }

  def to_en
    depth = -1
    tuples = self.to_s.reverse.scan /\d{1,3}/
    tuples.reduce('') do |phrase, triplet|
      ones(triplet.reverse.to_i.to_s, depth +=1) + phrase
    end.strip
  end

  private
  def suffix depth
    ['', 'thousand ', 'million ', 'billion ', 'trillion ', 'quadrillion '][depth]
  end

  def ones number, depth=0
    english = ONES[number] || teens(number)
    english += suffix(depth) unless english.empty?
    english
  end

  def teens number
    TEENS[number] || tens(number)
  end

  def tens number
    return hundreds number unless number.size == 2
    TENS[number[0]] + ones(number[1])
  end

  def hundreds number
    ones(number[0]) + 'hundred ' + ones(number[1,2])
  end
end

describe 'to_en' do
  class Integer
    include IntToEn
  end

  it 'works for ones' do
    4.to_en.should == 'four'
  end

  it 'works for ten' do
    10.to_en.should == 'ten'
  end

  it 'works for teens' do
    14.to_en.should == 'fourteen'
  end

  it 'works for non-teens' do
    24.to_en.should == 'twenty four'
  end

  it 'works for 40' do
    40.to_en.should == 'forty'
  end

  it 'works for 100' do
    100.to_en.should == 'one hundred'
  end

  it 'works for 101' do
    101.to_en.should == 'one hundred one'
  end

  it 'works for hundreds' do
    124.to_en.should == 'one hundred twenty four'
  end

  it 'works for 314' do
    314.to_en.should == 'three hundred fourteen'
  end

  it 'works for 238' do
    238.to_en.should == 'two hundred thirty eight'
  end

  it 'works for 1000' do
    1000.to_en.should == 'one thousand'
  end

  it 'works for 1001' do
    1001.to_en.should == 'one thousand one'
  end

  it 'works for thousands' do
    1124.to_en.should == 'one thousand one hundred twenty four'
  end

  it 'works for 2356' do
    2356.to_en.should == 'two thousand three hundred fifty six'
  end

  it 'works for 10000' do
    10000.to_en.should == 'ten thousand'
  end

  it 'works for 10001' do
    10001.to_en.should == 'ten thousand one'
  end

  it 'works for 40001' do
    40001.to_en.should == 'forty thousand one'
  end

  it 'works for 40000' do
    40000.to_en.should == 'forty thousand'
  end

  it 'works for 82356' do
    82356.to_en.should == 'eighty two thousand three hundred fifty six'
  end

  it 'works for 112356' do
    112356.to_en.should == 'one hundred twelve thousand three hundred fifty six'
  end

  it 'works for 1000000' do
    1000000.to_en.should == 'one million'
  end

  it 'works for 1000001' do
    1000001.to_en.should == 'one million one'
  end

  it 'works for 1112356' do
    1112356.to_en.should == 'one million one hundred twelve thousand three hundred fifty six'
  end

  it 'works for 1111112356' do
    1111112356.to_en.should == 'one billion one hundred eleven million one hundred twelve thousand three hundred fifty six'
  end

  it 'works for 1211111112356' do
    1211111112356.to_en.should == "one trillion two hundred eleven billion one hundred eleven million one hundred twelve thousand three hundred fifty six"
  end

  it 'works for 999991211111112356' do
    999991211111112356.to_en.should == "nine hundred ninety nine quadrillion nine hundred ninety one trillion two hundred eleven billion one hundred eleven million one hundred twelve thousand three hundred fifty six"
  end

  it 'works for identical triplets' do
    301301.to_en.should == 'three hundred one thousand three hundred one'
  end
end
