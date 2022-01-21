require_relative 'lang'

VERSION = {
	'en' => <<~TXT,
		Adapted from petemyron's speedtest gem
		  %{petemyron}
		Which is a gemmed version of lacostej's speedtest.rb
		  %{lacostej}
		Under MIT Licence
	TXT
	'es' => <<~TXT,
		Adaptado de la gema speedtest de petemyron
		  %{petemyron}
		La cual es una version gemada de speedtest.rb de lacostej
		  %{lacostej}
		Bajo Licencia MIT
	TXT
}.translate

def version
	puts "pspeedtest v#{PSpeedTest::VERSION} - Piero Rojas"
	puts VERSION % {
		'petemyron': 'https://github.com/petemyron/speedtest/',
		'lacostej': 'https://github.com/lacostej/speedtest.rb'
	}
	exit 0
end



