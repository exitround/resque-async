module ResqueAsync
  module Workers

    module AsyncClassWorker
      def perform(klass, method, args = [])
        if args.empty?
          klass.constantize.send(method)
        else
          klass.constantize.send(method, *args)
        end
      end
    end

    class HighPriorityClassMethod
      extend AsyncClassWorker
      @queue = :high
    end

    class LowPriorityClassMethod
      extend AsyncClassWorker
      @queue = :low
    end

    class MediumPriorityClassMethod
      extend AsyncClassWorker
      @queue = :medium
    end
  end
end
