# PSpeedTest

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
gem 'pspeedtest'
```

And then execute:

	$ bundle install

Or install it yourself as:

	$ gem install pspeedtest

## Usage

Create a new test object with any of the following optional arguments
* :download (Integer Array)
	* Sizes of the images to download
	* Only values in [500, 750, 1000, 1500, 2000, 2500, 3000, 3500, 4000]
	* defaults to [1_000] * 8
* :upload (Integer Array)
	* Sizes of the strings to upload
	* Any values
	* defaults to [400_000] * 8
* &block (Proc)
	* Block to run
	* defaults to pspeedtest::DEFAULT_BLOCK

Example with no arguments:

```ruby
require "pspeedtest"

test = pspeedtest.new
test.run
```

```ruby

--- Running test ---

User:
  IP: <your-ip>
  Coordinateds: <lat>, <lon>

Server:
  Sponsor: <host>
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
Took 13.2124 seconds to upload 3200000 bytes [1.85mbps]
```

See more at:
* [https://www.rubydoc.info/gems/pspeedtest](
	https://www.rubydoc.info/gems/pspeedtest)

Or check out the examples:
* [hello-pocha.rb and many more](
	https://github.com/ICanOnlySuffer/pspeedtest/tree/main/examples)

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





