require 'resque-async/enqueuers'

module ResqueAsync
  module Integrations
    module ActiveRecord
      def async(priority)
        Enqueuers::ActiveRecordEnqueuer.new(self.class, priority, self.id)
      end
    end

    module Core
      def async(priority)
        Enqueuers::ClassEnqueuer.new(self, priority)
      end
    end
  end
end