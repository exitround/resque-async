require 'support/enqueur'
require 'support/mock_host'

describe 'Enqueuers' do
  describe ResqueAsync::Enqueuers::ClassEnqueuer do
    it_behaves_like 'enqueuer' do
      subject{ ResqueAsync::Enqueuers::ClassEnqueuer.new(MockHost, :high)}
    end
  end
end