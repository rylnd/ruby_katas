describe BoardSquare do
  let(:subject) { BoardSquare.new(1,3) }

  context 'defaults' do
    context 'returns the correct coordinates' do
      its(:x) { should == 1 }
      its(:y) { should == 3 }
    end
  end

  context 'delegations' do
    let(:state) { mock('state') }

    before do
      subject.stub(:state => state)
    end

    it 'delegates #color to BoardState' do
      state.should_receive(:color)
      subject.color
    end

    it 'delegates #transition! to BoardState' do
      state.should_receive(:transition!)
      subject.transition!
    end

    describe 'dead/alive predicates' do
      it 'delegates #alive? to BoardState' do
        state.should_receive(:alive)
        subject.alive?
      end

      it 'delegates #dead? to BoardState' do
        state.should_receive(:alive)
        subject.dead?
      end
    end
  end

  describe '#neighbors' do
    it 'returns the right number of neighbors' do
      subject.neighbors.size.should == 8
    end

    it 'returns the surrounding coordinates' do
      subject.neighbors.should =~ [[2,3], [2,4],
                                   [1,4], [0,4],
                                   [0,3], [0,2],
                                   [1,2], [2,2]]
    end

    context 'point on an lower edge' do
      let(:subject) { BoardSquare.new(0,1) }
      it 'returns the right number of neighbors' do
        subject.neighbors.size.should == 5
      end

      it 'returns the surrounding coordinates' do
        subject.neighbors.should =~ [[0,0], [0,2],
                                     [1,0], [1,1],
                                     [1,2]]
      end
    end

    context 'point on a lower corner' do
      let(:subject) { BoardSquare.new(0,0) }
      it 'returns the right number of neighbors' do
        subject.neighbors.size.should == 3
      end

      it 'returns the surrounding coordinates' do
        subject.neighbors.should =~ [[0,1], [1,0],
                                     [1,1]]
      end
    end
  end

  describe 'marking for next step' do
    describe '#kill' do
      it 'is dead after step' do
        subject.kill
        subject.transition!
        subject.should be_dead
      end
    end

    describe '#resurrect' do
      it 'is alive after step' do
        subject.resurrect
        subject.transition!
        subject.should be_alive
      end
    end
  end
end
