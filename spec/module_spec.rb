require 'support/async'

describe Module do
  it_behaves_like 'async'
  it { expect(subject.async(:anything)).to be_kind_of(ResqueAsync::Enqueuers::ClassEnqueuer)}
end