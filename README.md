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
* download_runs: Sizes of the images to download, must be one or more of [350, 500, 750, 1000, 1500, 2000, 2500, 3000, 3500, 4000]
* upload_runs: Sizes of the strings to upload, may be of any sizes
* ping_runs: Times the server will be pinged
* censor: Censors private data such as your ip, your coords, the server url, its coords and it's distance from you
* debug: Either true or false, if it's set to true it will print debug information.

```ruby
require "pocha-speed-test"

test = PochaSpeedTest::Test.new ping_runs: 8,
	download_runs: [500, 1000, 1500, 2000],
	upload_runs: [500, 1000, 1500, 2000],
	censor: true,
	debug: true

test.run
```

If :debug and :censor are set to true it should print out something like this:

```ruby

--- Running test ---

User
  IP: <your-ip>
  Coords: <your-coords>
Server
  URL: <url>
  Coords: <coords> [<distance>]
  Latency: 6.55ms

Starting download tests:
  downloading images from <url>/speedtest/
Took 9.9204 seconds to download 9894024 bytes (7.61Mbit/s)

Starting upload tests:
  uploading strings to <url>/speedtest/upload.php
Took 0.0770 seconds to download 6016 bytes (610.04Kbit/s)
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



