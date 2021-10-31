# PochaSpeedTest

A RubyGem to test internet speed with [speedtest.net](speedtest.net) servers.

Adapted from [petemyron's speedtest gem](
	https://github.com/petemyron/speedtest/)
which is a gemmed version of [lacostej's speedtest.rb](
	https://github.com/lacostej/speedtest.rb)
whose inspiration was [fopina's pyspeedtest](
	https://github.com/fopina/pyspeedtest)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pocha-speed-test'
```

And then execute:

    $ bundle install

Or install it yourself as:

	$ gem install pocha-speed-test

## Usage

Create a new test object with any of the following options
* download_sizes: (Integer Array)
	* Sizes of the images to download
	* Only values in [350, 500, 750, 1000, 1500, 2000, 2500, 3000, 3500, 4000]
	* defaults to [1000, 1500, 2000, 2500]
* upload_sizes: (Integer Array)
	* Sizes of the strings to upload
	* Any values
	* defaults to [1000000, 1000000, 1000000, 1000000]
* pings: (Integer)
	* Times the server will be pinged
	* defaults to 4
* &block (Proc)
	* Block to run
	* defaults to PochaSpeedTest::TestBlocks::DEFAULT

```ruby
require "pocha-speed-test"

test = PochaSpeedTest.new
=> #<struct PochaSpeedTest::Test
	download_sizes=[1000, 1500, 2000, 2500],
	upload_sizes=[1000000, 1000000, 1000000, 1000000],
	pings=4,
	block=#<Proc:0x000055d245d3bf68 ~/.../pocha-speed-test/test-blocks.rb:4>>

test.run
```

With the default block it should output something like this:

```ruby

--- Running test ---

User
  IP: <your-ip>
  Coords: <your-latitude>, <your-longitude>
Server
  URL: <server-url>
  Coords: <server-latitude>, <server-longitude> [<server-distance>]
  Latency: 8.23ms

Starting download tests:
  downloading <server-url>/speedtest/random1000x1000.jpg
  downloading <server-url>/speedtest/random1500x1500.jpg
  downloading <server-url>/speedtest/random2000x2000.jpg
  downloading <server-url>/speedtest/random2500x2500.jpg
Took 14.7883 seconds to download 26770191 bytes (13.81Mbps)

Starting upload tests:
  uploading 976Kb to <server-url>/speedtest/upload.php
  uploading 976Kb to <server-url>/speedtest/upload.php
  uploading 976Kb to <server-url>/speedtest/upload.php
  uploading 976Kb to <server-url>/speedtest/upload.php
Took 16.5597 seconds to upload 4000032 bytes (1.84Mbps)
```

See more at:
* [https://www.rubydoc.info/gems/pocha-speed-test](
	https://www.rubydoc.info/gems/pocha-speed-test)

## Development

Install dependencies:

	$ ./bin/setup

Run tests:

	$ rake spec

Interactive Prompt:

	$ ./bin/console

Install into local machine:

	$ bundle exec rake install

Release a new version:

	$ bundle exec rake release

## Contributing

Bug reports and pull requests are welcome!

## License

The gem is available as open source under the terms of the [MIT License](
	https://opensource.org/licenses/MIT).

## Important links

petemyron's speedtest gem:
* [https://github.com/petemyron/speedtest/](
	https://github.com/petemyron/speedtest/)
* [https://rubygems.org/gems/plr-speedtest](
	https://rubygems.org/gems/plr-speedtest)

lacostej's speedtest.rb:
* [https://github.com/lacostej/speedtest.rb](
	https://github.com/lacostej/speedtest.rb)

fopina's pyspeedtest:
* [https://github.com/fopina/pyspeedtest](
	https://github.com/fopina/pyspeedtest)





