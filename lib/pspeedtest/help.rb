
require 'pspeedtest/lang/' + case ENV['LANG']
when /es/ then 'es'
when /pt/ then 'pt'
else 'en'
end

USAGE = "%{usage}: pspeedtest [%{value}...]\n%{options}:" % LANG
HELP = {
	download: [
		"'4000 4000'",
		'500 1000 1500 2000 2500 3000 3500 4000'
	],
	upload: ["'2000000 4000000 8000000'"],
	format: [
		'\'%F %X : %<download>.4f %{download}\\n\'',
		'host sponsor latency [upload/download](.[bits/time])(.sum)'
	],
	sleep: ['20'],
	runs: ['20']
}

EXAMPLE = <<~TXT
	#{LANG[:example]}:
	  $ pspeedtest -d'4000 4000' -r5 \\
	    -f'%F %X : %<download>.4f %{download}\\n' > internet.log
	  $ cat internet.log
	  2022-02-12 19:48:35 : 11.4803 Mbps
	  2022-02-12 19:49:18 : 15.8619 Mbps
	  2022-02-12 19:49:49 : 10.5070 Mbps
	  2022-02-12 19:50:36 : 16.1115 Mbps
	  2022-02-12 19:51:07 : 11.7380 Mbps
TXT

