require 'resque-async/version'
require 'resque-async/integrations'
require 'resque-async/workers'


module ResqueAsync

end

class Module
  include ResqueAsync::Integrations::Core
end

if defined? ::ActiveRecord
  class ActiveRecord::Base
    include ResqueAsync::Integrations::ActiveRecord
  end
end


