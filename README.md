# AASM Diagram

[AASM Diagram](https://github.com/katee/aasm-diagram) creates diagrams for [ASSM](https://github.com/aasm/aasm) state machines. To take an example from the AASM Readme:

```ruby
require 'aasm-diagram'

class Job
  include AASM

  aasm do
    state :sleeping, :initial => true
    state :running, :cleaning

    event :run do
      transitions :from => :sleeping, :to => :running
    end

    event :clean do
      transitions :from => :running, :to => :cleaning
    end

    event :sleep do
      transitions :from => [:running, :cleaning], :to => :sleeping
    end
  end
end

job = Job.new

AASMDiagram::Diagram.new(job.aasm, 'docs/job.png')
```

Generates the following diagram:

![Diagram of Job state machine](docs/job.png)

AASM Diagram is heavily inspired by [rails-erd](https://github.com/voormedia/rails-erd).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aasm-diagram'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aasm-diagram

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
