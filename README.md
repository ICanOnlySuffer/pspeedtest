# pspeedtest (pocha-speed-test)

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

### Within Ruby

Create a new PSpeedTest with any of these optional arguments:
- :download (Integer Array)
  - Sizes of the images to download
  - Only values in [500, 750, 1000, 1500, 2000, 2500, 3000, 3500, 4000]
  - Defaults to [1000] * 8
- :upload (Integer Array)
  - Sizes of the strings to upload
  - Any values
  - Defaults to [400000] * 8
- &block (Proc)
  - Proc to run
  - Defaults to PSpeedTest::DEFAULT_BLOCK

Example 1:

```ruby
require "pspeedtest"

test = PSpeedTest.new download: [1000] * 4, upload: [1000000] * 4 do |test|
	puts nil, "--- Running custom Test ---", nil
	
	PSpeedTest::USER.update!
	puts PSpeedTest::SERVER.update!.to_s debug: <<~TXT
		Server: %{sponsor} (%<latency>.4fms)\n
	TXT
	
	puts "Starting download tests..."
	download = PSpeedTest::SERVER.download_speed test.to_download,
		debug: "  downloading %{url}\n"
	puts download.to_s debug: "Download speed: %{bps}\n\n"
	
	puts "Starting upload tests..."
	upload = PSpeedTest::SERVER.upload_speed test.to_upload,
		debug: "  uploading %{bytes} to %{url}\n"
	puts upload.to_s debug: "Upload speed: %{bps}\n\n"
end

test.run
```

```ruby

--- Running custom Test ---

Server: <sponsor> (18.9144ms)

Starting download tests:
  downloading http://<host>/speedtest/random1000x1000.jpg
  downloading http://<host>/speedtest/random1000x1000.jpg
  downloading http://<host>/speedtest/random1000x1000.jpg
  downloading http://<host>/speedtest/random1000x1000.jpg
Download speed: 20.83mbps

Starting upload tests:
  uploading 976Kb to http://<host>/speedtest/upload.php
  uploading 976Kb to http://<host>/speedtest/upload.php
  uploading 976Kb to http://<host>/speedtest/upload.php
  uploading 976Kb to http://<host>/speedtest/upload.php
Upload speed: 2.83mbps

```

Example 2:

```ruby
require "pspeedtest"

PSpeetest.new.run
```

```ruby

--- Running test ---

User:
  IP: <ip>
  Coordinates: <lat>, <lon>

Server:
  Sponsor: <sponsor> (<host>)
  Latency: <latency>
  Coordinates: <lat>, <lon> [<distance>]

Starting download tests:
  downloading http://<host>/speedtest/random1000x1000.jpg
  downloading http://<host>/speedtest/random1000x1000.jpg
  downloading http://<host>/speedtest/random1000x1000.jpg
  downloading http://<host>/speedtest/random1000x1000.jpg
  downloading http://<host>/speedtest/random1000x1000.jpg
  downloading http://<host>/speedtest/random1000x1000.jpg
  downloading http://<host>/speedtest/random1000x1000.jpg
  downloading http://<host>/speedtest/random1000x1000.jpg
Took 11.4802 seconds to download 190683264 bits [15.84mbps]

Starting upload tests:
  uploading 390Kb to http://<host>/speedtest/upload.php
  uploading 390Kb to http://<host>/speedtest/upload.php
  uploading 390Kb to http://<host>/speedtest/upload.php
  uploading 390Kb to http://<host>/speedtest/upload.php
  uploading 390Kb to http://<host>/speedtest/upload.php
  uploading 390Kb to http://<host>/speedtest/upload.php
  uploading 390Kb to http://<host>/speedtest/upload.php
  uploading 390Kb to http://<host>/speedtest/upload.php
Took 13.0868 seconds to upload 38400000 bits [2.80mbps]

```

### Command line:

Still in development.

```bash
$ pspeedtest
```

See more at:
* [https://www.rubydoc.info/gems/pspeedtest](
	https://www.rubydoc.info/gems/pspeedtest)

## Development

Run tests:

	$ rake spec

Install into local machine:

	$ bundle exec rake install

Release a new version:

	$ bundle exec rake release

## Contributing

Bug reports, suggestions and pull requests are welcome!

Also if you make something cool with this gem I would gladly link to it.

## License

The gem is available as open source under the terms of the [MIT License](
	https://opensource.org/licenses/MIT).

## Important links

petemyron's speedtest gem:
- [https://github.com/petemyron/speedtest/](
	https://github.com/petemyron/speedtest/)
- [https://rubygems.org/gems/plr-speedtest](
	https://rubygems.org/gems/plr-speedtest)

lacostej's speedtest.rb:
- [https://github.com/lacostej/speedtest.rb](
	https://github.com/lacostej/speedtest.rb)

fopina's pyspeedtest:
- [https://github.com/fopina/pyspeedtest](
	https://github.com/fopina/pyspeedtest)





