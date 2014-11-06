module ResqueAsync
  module Workers

    class AsyncClassWorker
      def perform(klass, method, args = [])
        if args.empty?
          klass.constantize.send(method)
        else
          klass.constantize.send(method, *args)
        end
      end
    end

    class HighPriorityClassMethod < AsyncClassWorker
      @queue = :high
    end

    class LowPriorityClassMethod < AsyncClassWorker
      @queue = :low
    end

    class MediumPriorityClassMethod < AsyncClassWorker
      @queue = :medium
    end
  end
end
