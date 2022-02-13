
require 'pspeedtest/lang/' + case ENV['LANG']
when /es/ then 'es'
when /pt/ then 'pt'
else 'en'
end

USAGE = "%{usage}: pspeedtest [%{value}...]\n%{options}:" % LANG
HELP = {
	download: ["'4000 4000'", "'1000 2000 3000 4000'"],
	upload: ["'2000000 4000000 8000000'"],
	format: ["'%<upload.num>.4f %{upload.str}\\n'", %[
		host
		sponsor
		latency
		latitude
		longitude
		download.num.sum
		download.str.sum
		download.bits.sum
		download.time.sum
		upload.num.sum
		upload.str.sum
		upload.bits.sum
		upload.time.sum
		download.num
		download.str
		download.bits
		download.time
		upload.num
		upload.str
		upload.bits
		upload.time
	]],
	sleep: ['20'],
	runs: ['20']
}

EXAMPLES = [
	<<~TXT,
		  $ pspeedtest -d'4000 4000' -r5 \\
		    -f'%F %X : %<download>.4f %{download}\\n' > internet.log
		  $ cat internet.log
		  2022-02-12 19:48:35 : 11.4803 Mbps
		  2022-02-12 19:49:18 : 15.8619 Mbps
		  2022-02-12 19:49:49 : 10.5070 Mbps
		  2022-02-12 19:50:36 : 16.1115 Mbps
		  2022-02-12 19:51:07 : 11.7380 Mbps
		\0
	TXT
	<<~TXT
		$ pspeedtest -d2000 -u8000000 -r5 \\
		  -f'%<download>.4f %{download} %<upload>.4f %{upload}\\n'
	TXT
]

