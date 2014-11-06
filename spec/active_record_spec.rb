require 'support/async'

describe ActiveRecord::Base do
  it_behaves_like 'async'
  it { expect(subject.async(:anything)).to be_kind_of(ResqueAsync::Enqueuers::ActiveRecordEnqueuer)}
end
