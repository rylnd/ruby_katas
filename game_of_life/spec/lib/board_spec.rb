describe Board do
  let(:subject) { Board.new(options) }
  let(:options) { {} }

  describe 'defaults' do
    its(:size) { should == 20 }
    its(:steps) { should == 100 }

    context 'overriding defaults' do
      let(:options) { { :size => 100, :steps => 1000 } }
      its(:size) { should == 100 }
      its(:steps) { should == 1000 }
    end
  end

  describe 'grid' do
    it 'can enumerate rows' do
      subject.rows.should respond_to(:each)
    end

    it 'can enumerate within a row' do
      subject.rows.first.should respond_to(:each)
    end
  end

  describe '#cells' do
    it 'returns the array of size * size cells' do
      subject.cells.size.should == 400
    end

    it 'returns an array of living/dead cells' do
      subject.cells.first.should respond_to(:dead?)
      subject.cells.first.should respond_to(:alive?)
    end
  end

  describe '#each_cell' do
    let(:cells) { subject.rows.flatten.map { |cell| [cell, cell.x, cell.y] } }

    it 'yields each cell' do
      expect { |block| subject.each_cell &block }.to yield_successive_args(*cells)
    end
  end

  describe '#run!' do
    it 'steps the specified number of times and prints' do
      subject.stub(:print => true)
      subject.should_receive(:step).exactly(100).times

      subject.run!
    end
  end
end
