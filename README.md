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
* download_runs: Sizes of the images to download, mut be one or more of [350, 500, 750, 1000, 1500, 2000, 2500, 3000, 3500, 4000]
* upload_runs: Sizes of the strings to upload, may be of any size
* ping_runs: Times the server will be pinged
* debug: Either true or false, if it's set to true it will print debug information.

```ruby
require "pocha-speed-test"

test = PochaSpeedTest::Test.new debug: true,
	download_runs: [350, 500, 750, 1000, 1500],
	upload_runs: [350, 500, 750, 1000, 1500],
	ping_runs: 8

result = test.run
```

If debug is set to true it should print out something like this:

```ruby
User
  IP: <your ip>
  Coords: <latitude>, <longitude>
Server
  URL: <url>
  Coords: <latitude>, <longitude> [<distance>]
  Latency: 57.33ms

Starting download tests:
  downloading: <url>/speedtest/random350x350.jpg
  downloading: <url>/speedtest/random500x500.jpg
  downloading: <url>/speedtest/random750x750.jpg
  downloading: <url>/speedtest/random1000x1000.jpg
  downloading: <url>/speedtest/random1500x1500.jpg
Took 4.8482 seconds to download 8323469 bytes (5 threads)
Download: 13.10Mbit/s

Starting upload tests:
  uploading: <url>/speedtest/upload.php
  uploading: <url>/speedtest/upload.php
  uploading: <url>/speedtest/upload.php
  uploading: <url>/speedtest/upload.php
  uploading: <url>/speedtest/upload.php
Took 0.1321 seconds to upload 4140 bytes (5 threads)
Upload: 244.78Kbit/s
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome!

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

# Important links

lacostej's speedtest.rb: [GitHub](https://github.com/lacostej/speedtest.rb)
petemyron's gemmed version: [GitHub](https://github.com/petemyron/speedtest/)

