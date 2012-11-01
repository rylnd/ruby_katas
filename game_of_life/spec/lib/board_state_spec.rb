describe BoardState do
  let(:subject) { BoardState.new }
  context 'defaults' do
    context '#char' do
      it 'starts with a space char' do
        subject.char.should == ' '
      end
    end
  end

  describe '#transition!' do
    let(:next_state) { nil }
    before { subject.transition!(next_state) }

    context 'without a next state' do
      it 'stays empty' do
        subject.char.should == ' '
      end
    end

    context 'with a next state of alive' do
      let(:next_state) { true }

      it 'becomes #' do
        subject.char.should == '#'
      end
    end

    context 'with a next state of dead' do
      let(:next_state) { false }

      it 'becomes black(dead)' do
        subject.char.should == ' '
      end
    end
  end
end
