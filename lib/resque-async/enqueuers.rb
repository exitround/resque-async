require 'resque'

module ResqueAsync
  module Enqueuers

    class ClassEnqueuer
      attr_reader :host_class, :priority
      def initialize(host_class, priority)
        @host_class = host_class
        @priority = priority
      end

      def method_missing(methId, *args)
        # call super unless the host responds to the method
        return super unless @host_class.respond_to?(methId.id2name.to_sym)

        queue_name ||= @priority.to_s

        case @priority
          when Class
            worker = @priority
            queue_name = Resque.queue_from_class(worker)
          when :high, 'high'
            worker = Workers::HighPriorityClassMethod
          when :medium, 'medium'
            worker = Workers::MediumPriorityClassMethod
          when :low, 'low'
            worker = Workers::LowPriorityClassMethod
          when :realtime, 'realtime'
            return args.empty? ? @host_class.send(methId.id2name) : @host_class.send(methId.id2name, *args)
          else
            worker = Workers::AdhocPriorityClassMethod
        end

        Resque.enqueue_to(queue_name, worker, @host_class.name, methId.id2name, args)
      end
    end

    class ActiveRecordEnqueuer < ClassEnqueuer
      def initialize(host_class, priority, id)
        super(host_class, priority)
        @id = id
      end

      def method_missing(methId, *args)
        return super(methId, args) unless @host_class.method_defined?(methId)
        self.class::async(@priority).find_and_send(@host_class.name, @id, methId.id2name, args)
      end

      def self.find_and_send(class_name, id, method_name, args)
        record = class_name.constantize.find(id)
        if args.empty?
          record.send(method_name)
        else
          record.send(method_name, *args)
        end
      end
    end
  end
end
