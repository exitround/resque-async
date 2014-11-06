# ResqueAsync

A simple way to invoke methods asynchronously using Resque. There are a few gems that provide similar functionality.
However We like the more declarative syntax with this implementation. As it gives the caller control over the invocation

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

Supports Class Methods and ActiveRecord instance methods

```ruby
MyObject.async(:high).slow_class_method
record_instance.async(:medium).slow_instance_method
```

Support high, medium, low priority out of the box. As well as custom work/queue

```ruby
MyObject.async(:high).high_priority
MyObject.async(:medium).medium_priority
MyObject.async(:low).low_priority
```
OR
```ruby
class MyCustomerWorker
    extend ResqueAsync::Workers::AsyncClassWorker
    @queue :crazy
end 
MyObject.async(MyCustomerWorker).crazy_priority
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/resque-async/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
