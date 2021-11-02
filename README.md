# PochaSpeedTest

A RubyGem to test internet speed with [speedtest.net](
	https://www.speedtest.net/) servers.

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
	* defaults to [1_000] * 8
* upload_sizes: (Integer Array)
	* Sizes of the strings to upload
	* Any values
	* defaults to [400_000] * 8
* ping: (Enumerator)
	* Times the server will be pinged
	* defaults to 4.times
* &block (Proc)
	* Block to run
	* defaults to PochaSpeedTest::BLOCKS[:default]

```ruby
require "pocha-speed-test"

test = PochaSpeedTest.new
test.run
```

With the default block it should output something like this:

```ruby
--- Running test ---

User:
  IP: <your-ip>
  Coords: <lat>, <lon>
Server:
  Host: <host>
  Coords: <lat>, <lon> [<distance>]

Starting download tests:
  downloading http://<host>/speedtest/random1000x1000.jpg
  downloading http://<host>/speedtest/random1000x1000.jpg
  downloading http://<host>/speedtest/random1000x1000.jpg
  downloading http://<host>/speedtest/random1000x1000.jpg
  downloading http://<host>/speedtest/random1000x1000.jpg
  downloading http://<host>/speedtest/random1000x1000.jpg
  downloading http://<host>/speedtest/random1000x1000.jpg
  downloading http://<host>/speedtest/random1000x1000.jpg
Took 9.0169 seconds to download 15890272 bytes [13.45mbps]

Starting upload tests:
  uploading 390Kb to http://<host>/speedtest/upload.php
  uploading 390Kb to http://<host>/speedtest/upload.php
  uploading 390Kb to http://<host>/speedtest/upload.php
  uploading 390Kb to http://<host>/speedtest/upload.php
  uploading 390Kb to http://<host>/speedtest/upload.php
  uploading 390Kb to http://<host>/speedtest/upload.php
  uploading 390Kb to http://<host>/speedtest/upload.php
  uploading 390Kb to http://<host>/speedtest/upload.php
Took 13.2124 seconds to download 3200000 bytes [1.85mbps]
```

See more at:
* [https://www.rubydoc.info/gems/pocha-speed-test](
	https://www.rubydoc.info/gems/pocha-speed-test)

Or check out the tests/examples:
* [hello-pocha.rb and many more](
	tests/)

Or at PochaSpeedTestLogger
* [stil in development](
	https://github.com/ICanOnlySuffer/PochaSpeedTestLogger)

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

Bug reports, suggestions and pull requests are welcome!

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





