describe BoardState do
  let(:subject) { BoardState.new }
  context 'defaults' do
    it 'starts with a color of black' do
      subject.color.should == :black
    end
  end

  context '#transition!' do
    it 'transitions from black to blue' do
      subject.transition!
      subject.color.should == :blue
    end

    it 'transitions from blue to red' do
      2.times { subject.transition! }
      subject.color.should == :red
    end

    it 'transitions from red to yellow' do
      3.times { subject.transition! }
      subject.color.should == :yellow
    end

    it 'transitions from yellow to black' do
      4.times { subject.transition! }
      subject.color.should == :black
    end
  end
end
