describe BoardState do
  let(:subject) { BoardState.new }
  context 'defaults' do
    it 'starts with a color of black(dead)' do
      subject.color.should == :black
    end
  end

  describe '#transition!' do
    let(:next_state) { nil }
    before { subject.transition!(next_state) }

    context 'without a next state' do
      it 'stays black(dead)' do
        subject.color.should == :black
      end
    end

    context 'with a next state of alive' do
      let(:next_state) { true }

      it 'becomes white(alive)' do
        subject.color.should == :white
      end
    end

    context 'with a next state of dead' do
      let(:next_state) { false }

      it 'becomes black(dead)' do
        subject.color.should == :black
      end
    end
  end
end
