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

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aasm-diagram', require: false, group: :development
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aasm-diagram

## More Examples

### Guards

```ruby
class Cleaner
  include AASM

  aasm do
    state :idle, :initial => true
    state :cleaning

    event :clean do
      transitions :from => :idle, :to => :cleaning, :guard => :cleaning_needed?
    end

    event :clean_if_needed do
      transitions :from => :idle, :to => :cleaning do
        guard do
          cleaning_needed?
        end
      end
      transitions :from => :idle, :to => :idle
    end

    event :clean_if_dirty do
      transitions :from => :idle, :to => :cleaning, :guard => :if_dirty?
    end
  end

  def cleaning_needed?
    false
  end

  def if_dirty?(status)
    status == :dirty
  end
end

cleaner = Cleaner.new
AASMDiagram::Diagram.new(job.aasm, '../docs/guard-cleaner.png')
```

![Diagram of Cleaner state machine](docs/guard-cleaner.png)

### Multiple state machines per class

```ruby
class SimpleMultipleExample
  include AASM
  aasm(:move) do
    state :standing, :initial => true
    state :walking
    state :running

    event :walk do
      transitions :from => :standing, :to => :walking
    end
    event :run do
      transitions :from => [:standing, :walking], :to => :running
    end
    event :hold do
      transitions :from => [:walking, :running], :to => :standing
    end
  end

  aasm(:work) do
    state :sleeping, :initial => true
    state :processing

    event :start do
      transitions :from => :sleeping, :to => :processing
    end
    event :stop do
      transitions :from => :processing, :to => :sleeping
    end
  end
end

simple = SimpleMultipleExample.new
AASMDiagram::Diagram.new(simple.aasm(:move), 'docs/multiple-state-machines-1.png')
AASMDiagram::Diagram.new(simple.aasm(:work), 'docs/multiple-state-machines-2.png')
```

Geneartes two images:

![Diagram of state machine 1](docs/multiple-state-machines-1.png)
![Diagram of state machine 2](docs/multiple-state-machines-2.png)

## Notes

AASM Diagram is heavily inspired by [rails-erd](https://github.com/voormedia/rails-erd).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
