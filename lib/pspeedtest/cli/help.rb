
case ENV['LANG']
when /es/
	USAGE = 'Uso'
	VALUE = 'OPCIÓN=VALOR'
	OPTIONS = 'Options'
	ALLOWED = 'Valores permitidos'
	EXAMPLE = 'Ejemplo'
	DOWNLOAD = 'Tamaños de las imágenes a descargar'
	UPLOAD = 'Tamaños de las cadenas a subir'
	DEBUG = 'Cadena a ser formateada'
	DELAY = 'Segundos entre iteraciones'
	RUNS = 'Veces a correr el bucle (vacío para infinitas veces)'
	FILE = 'Archivo en el cual se escribirá'
when /pt/
	USAGE = 'Uso'
	VALUE = 'OPÇÃO=VALOR'
	OPTIONS = 'Opções'
	ALLOWED = 'Valores permitidos'
	EXAMPLE = 'Exemplo'
	DOWNLOAD = 'Tamanhos das imagens para download'
	UPLOAD = 'Tamanhos de string para upload'
	DEBUG = 'String a ser formatada'
	DELAY = 'Segundos entre as iterações'
	RUNS = 'Vezes para executar o loop (vazio por infinitas vezes)'
	FILE = 'Arquivo para gravar'
else
	USAGE = 'Usage'
	VALUE = 'OPTION=VALOR'
	OPTIONS = 'Options'
	ALLOWED = 'Allowed values'
	EXAMPLE = 'Example'
	DOWNLOAD = 'Sizes of the images to download'
	UPLOAD = 'Sizes of the strings to uplload'
	DEBUG = 'String to be formated'
	DELAY = 'Seconds between iterations'
	RUNS = 'Times to run the loop (emtpy for infinite times)'
	FILE = 'Archivo en el cual se escribirá'
end

puts <<~TXT
	#{USAGE}: pspeedtest [#{VALUE}...]
	#{OPTIONS}:
	  --download=ARRAY  #{DOWNLOAD}.
	                    #{ALLOWED}:
	                      500 1000 1500 2000 2500 3000 3500 4000
	                    #{EXAMPLE}:
	                      --download='500 1500 2500 3500'
	  --upload=ARRAY    #{UPLOAD}.
	                    #{EXAMPLE}:
	                      --upload='2000000 4000000 6000000 8000000'
	  --debug=STRING    #{DEBUG}.
	                    #{ALLOWED}:
	                      host (string)
	                      sponsor (string)
	                      latency (float)
	                      longitude (float)
	                      distance (float)
	                      distance.m (float)
	                      distance.mi (float)
	                      total.download.num (float)
	                      total.download.str (string)
	                      total.download.bits (integer)
	                      total.download.time (float)
	                      total.upload.num (float)
	                      total.upload.str (string)
	                      total.upload.bits (integer)
	                      total.upload.time (float)
	                      download.num (float)
	                      download.str (string)
	                      download.bits (integer)
	                      download.time (float)
	                      upload.num (float)
	                      upload.str (string)
	                      upload.bits (integer)
	                      upload.time (float)
	                    #{EXAMPLE}:
	                      --debug='%<upload.num>.4f %{upload.str}\\n'
	  --delay=NUMBER    #{DELAY}.
	                    #{EXAMPLE}:
	                      --delay=20
	  --runs=NUMBER     #{RUNS}.
	                    #{EXAMPLE}:
	                      --runs=20
	  --file=STRING     #{FILE}.
	                    #{EXAMPLE}:
	                      --file='~/Documents/internet.log'
	#{EXAMPLE}:
	  $ pspeedtest \\
	    --download='4000 4000 4000 4000' \\
	    --debug='%{time}: %<download.num>.4f %{download.str}\\n' \\
	    --file='internet.log' \\
	    --runs=20
TXT

exit

