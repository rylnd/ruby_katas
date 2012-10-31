describe Board do
  let(:subject) { Board.new }

  describe 'defaults' do
    its(:size) { should == 20 }
    its(:steps) { should == 100 }
  end

  describe 'board' do
    it 'can enumerate rows' do
      subject.rows.should respond_to(:each)
    end

    it 'can enumerate within a row' do
      subject.rows.first.should respond_to(:each)
    end
  end
end
