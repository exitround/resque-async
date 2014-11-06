shared_examples 'enqueuer' do
  it { expect{ subject.not_a_method }.to raise_error(NoMethodError)}
  it { expect{ subject.async_class_method }.to_not raise_error }
end