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

	$ gem install pspeedtest

## Usage

**Within Ruby:**

```ruby
require 'pspeedtest'

# update USER
PSpeedTest::USER.update!
=> #<struct ip, lat, lon>

# update SERVER
PSpeedTest::SERVER.update!
=> #<struct lat, lon, host, sponsor, latency>

# make a custom test
def test
	download_speed = PSpeedTest::SERVER.download [4000] * 4,
		debug: 'downloading %{url}'
	upload_speed = PSpeedTest::SERVER.upload [8000] * 8,
		debug: 'uploading %{size} bytes to %{url}'
	
	puts "download speed: #{download_speed}"
	puts "upload speed: #{upload_speed}"
end

# run it!
test
```

**On the command line:**

	$ pspeedtest \
		--download='4000 4000 4000 4000' \
		--debug='%{time}: %<download.num>.4f %{download.str}\n' \
		--file='internet.log' \
		--runs=5

*internet.txt:*

```
2022-01-20 21:44:40 -0500: 771.3027 Kbps
2022-01-20 21:44:47 -0500: 1.0936 Mbps
2022-01-20 21:44:53 -0500: 475.1595 Kbps
2022-01-20 21:45:03 -0500: 877.3065 Kbps
2022-01-20 21:45:12 -0500: 231.7904 Kbps
```

Use --help to see the full list of arguments

	$ pspeedtest --help

See more at:
* [https://www.rubydoc.info/gems/pspeedtest](
	https://www.rubydoc.info/gems/pspeedtest)

## Contributing

Bug reports, suggestions and pull requests are welcome!

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

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

