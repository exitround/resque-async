shared_examples 'worker' do
  it { expect(described_class).to respond_to(:perform)}
end