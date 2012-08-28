describe BoardSquare do
  let(:subject) { BoardSquare.new(1,3) }

  context 'defaults' do
    context 'returns the correct coordinates' do
      its(:x) { should == 1 }
      its(:y) { should == 3 }
    end
  end

  context 'delegations' do
    it 'delegates #color to BoardState' do
      BoardState.any_instance.should_receive(:color)
      subject.color
    end

    it 'delegates #transition! to BoardState' do
      BoardState.any_instance.should_receive(:transition!)
      subject.transition!
    end
  end

  describe '#left?' do
    it 'returns true in its first two states' do
      subject.left?.should be_true
      subject.transition!
      subject.left?.should be_true
    end

    it 'returns false in its second two states' do
      2.times { subject.transition! }
      subject.left?.should be_false
      subject.transition!
      subject.left?.should be_false
    end
  end
end
