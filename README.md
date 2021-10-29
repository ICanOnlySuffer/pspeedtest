# PochaSpeedTest

## Installation

Add this line to your application's Gemfile:

```ruby
gem "pocha-speed-test"
```

And then excecute:

	$ bundle

Or in the future install it yourself:

	$ gem install pocha-speed-test

## Usage

```ruby
require "pocha-speed-test"

test = SpeedTest::Test.new debug: true,
	download_runs: [350, 500, 750, 1000, 1500] * 2,
	upload_runs: [350, 500, 750, 1000, 1500] * 2,
	ping_runs: 8

result = test.run
```

## Development

Stuff here













