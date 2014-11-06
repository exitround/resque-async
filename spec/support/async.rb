shared_examples 'async' do
  it { expect(subject).to respond_to(:async) }
end