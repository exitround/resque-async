# ResqueAsync

A simple way to invoke methods asynchronously using Resque. There are a few gems that provide similar functionality.
However this this implementation provides more expressive syntax that it gives the caller control over the invocation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'resque-async'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install resque-async

## Usage

Assuming

```ruby
class MyObject < ActiveRecord::Base
    def self.slow_class_method
    end
    def slow_instance_method
    end
end
```

Supports Class Methods and ActiveRecord instance methods

```ruby
MyObject.async(:high).slow_class_method

# ActiveRecord instances will be queued/loaded/invoked asynchronously
MyObject.new.async(:medium).slow_instance_method
```

Natural synchronous invocation
```ruby
    MyObject.slow_class_method
    MyObject.new.slow_instance_method
```

Support high, medium, low priority out of the box. As well as custom worker/queue

```ruby
# slow_class_method queued/invoked on 'high' queue
MyObject.async(:high).slow_class_method

# slow_class_method queued/invoked on 'medium' queue
MyObject.async(:medium).slow_class_method

# slow_class_method queued/invoked on 'low' queue
MyObject.async(:low).slow_class_method
```
OR
```ruby
class MyCustomerWorker
    extend ResqueAsync::Workers::AsyncClassWorker
    @queue :crazy
end 
MyObject.async(MyCustomerWorker).crazy_priority
```

## What about resque-async-method?

[resque-async-method](https://github.com/nragaz/resque-async-method) hides the fact that a method may be invoked asynchronously. 
From the caller's perspective things can get really confusing.

With resque-async-method
```ruby
class MyObject < ActiveRecord::Base
    def slow_method
    end
    async_method :slow_method
end

# is this async or not? What does result equal? Better check the implementation of MyObject
result = MyObject.slow_method 
```

With resque-async
```ruby
class MyObject < ActiveRecord::Base
    def slow_method
    end
end

# this should be pretty obvious years later that slow_method is invoked async
d = MyObject.async(:low).slow_method
```

## Contributing

1. Fork it ( https://github.com/exitround/resque-async/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
