require 'support/worker'

describe 'Workers' do

  describe ResqueAsync::Workers::HighPriorityClassMethod do
    it_behaves_like 'worker'
    it { expect(Resque.queue_from_class(described_class)).to be(:high)}
  end
  describe ResqueAsync::Workers::MediumPriorityClassMethod do
    it_behaves_like 'worker'
    it { expect(Resque.queue_from_class(described_class)).to be(:medium)}
  end
  describe ResqueAsync::Workers::LowPriorityClassMethod do
    it_behaves_like 'worker'
    it { expect(Resque.queue_from_class(described_class)).to be(:low)}
  end
end