# PochaSpeedTest

A ruby gem to test internet speed with speedtest.net

Adapted from [petemyron's speedtest](https://github.com/petemyron/speedtest/)

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
	* Sizes of the images to download, they must be in [350, 500, 750, 1000, 1500, 2000, 2500, 3000, 3500, 4000]
	* defaults to [1000, 1500, 2000, 2500]
* upload_sizes: (Integer Array)
	* Sizes of the strings to upload, they can be of any sizes
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
=> #<struct PochaSpeedTest::Test download_sizes=[1000, 1500, 2000, 2500], upload_sizes=[1000000, 1000000, 1000000, 1000000], pings=4, block=#<Proc:0x000055d245d3bf68 ~/.local/share/gem/ruby/3.0.0/gems/pocha-speed-test-0.1.3/lib/pocha-speed-test/test-blocks.rb:4>>

test.run
```

With the default block it should output something like this

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome!

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

# Important links

lacostej's speedtest.rb: [https://github.com/lacostej/speedtest.rb](https://github.com/lacostej/speedtest.rb)

petemyron's gemmed version:
* [https://github.com/petemyron/speedtest/](https://github.com/petemyron/speedtest/)
* [https://rubygems.org/gems/plr-speedtest](https://rubygems.org/gems/plr-speedtest)



