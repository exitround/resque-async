shared_examples 'worker' do
  it { expect(subject).to respond_to(:perform)}
end