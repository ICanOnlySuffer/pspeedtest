
VERSION = "pspeedtest #{PSpeedTest::VERSION} - Piero Rojas\n" + {
	"en" => <<~TXT,
		Adapted from petemyron's speedtest gem
		  %{petemyron}
		Which is a gemmed version of lacostej's speedtest.rb
		  %{lacostej}
		
		Under MIT Licence (Jerome Lacoste)
	TXT
	"es" => <<~TXT,
		Adaptado de la gema speedtest de petemyron
		  %{petemyron}
		La cual es una version gemada de speedtest.rb de lacostej
		  %{lacostej}
		
		Bajo Licencia MIT (Jerome Lacoste)
	TXT
}.in_lang % {
	petemyron: "https://github.com/petemyron/speedtest/",
	lacostej: "https://github.com/lacostej/speedtest.rb"
}




