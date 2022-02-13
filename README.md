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

# update SERVER
PSpeedTest::SERVER.update!

# make a custom test
def test
	download = PSpeedTest::SERVER.download [4000] * 4
	upload = PSpeedTest::SERVER.upload [8000] * 8
	
	puts "download speed: %.4f %s" % download
	puts "upload speed: %.4f %s" % upload
end

# run it!
test
```

**On the command line:**

	$ pspeedtest -d'4000 4000' -r5 \
	    -f'%F %X : %<download>.4f %{download}\n' > internet.log

*internet.log:*

```
2022-02-12 19:48:35 : 11.4803 Mbps
2022-02-12 19:49:18 : 15.8619 Mbps
2022-02-12 19:49:49 : 10.5070 Mbps
2022-02-12 19:50:36 : 16.1115 Mbps
2022-02-12 19:51:07 : 11.7380 Mbps
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

