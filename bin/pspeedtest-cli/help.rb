
ALLOWED_VALUES = {
	download: [500, 750, 1000, 1500, 2000, 2500, 3000, 3500],
	debug: <<~TXT.chomp
		#{}      server:
		#{}        {sponsor}, {host}, <latitude>, <longitude>, <latency>
		#{}      upload/download:
		#{}        {bits}, {time}, {bps}
	TXT
}.freeze

EXAMPLES = {
	download: "--download=500,1500,2500,3500",
	upload: "--upload=2000000,4000000,6000000,8000000"
}.freeze

HELP = {
	"en" => {
		"usage" => "usage: [OPTION=VALUE]...\n",
		"download" => <<~TXT,
			--download=(Integer Array)
			  - Sizes of the images to download.
			  - Only values in:
			#{ALLOWED_VALUES[:download]}
			  - By default: [1000] * 8
			  - Example:
			      #{EXAMPLES[:download]}
		TXT
		"upload" => <<~TXT,
			--upload=(Integer Array)
			  - Sizes of the strings to upload
			  - By default: [4000000] * 8
			  - Example:
			      #{EXAMPLES[:upload]}
		TXT
		"debug" => <<~TXT,
			--debug=(String)
			  - String to be formated
			  - Only values in:
			#{ALLOWED_VALUES[:debug]}
			  - Example:
			    --debug="Speed: %{download.bps} %{upload.bps}"
		TXT
		"delay" => <<~TXT,
			--delay=(Integer)
			  - Time to sleep between runs
			  - Example:
			    --delay=20
		TXT
		"runs" => <<~TXT,
			--runs=(Integer or String)
			  - Times to run the block
			  - Only valid String is: "infinity"
			  - Example:
			    --runs=20
		TXT
		"file" => <<~TXT,
			--file=(String)
			  - File in which the output will be saved.
			  - Example:
			    --file="~/Documents/internet-speed.log"
		TXT
		"print_errors" => <<~TXT,
			--print_errors=(Boolean)
			  - Prints connection errors
			  - By default: false
		TXT
	},
	"es" => {
		"usage" => "uso: [OPCIÓN=VALOR]...\n",
		"download" => <<~TXT,
			--download=(Arreglo de Enteros)
			  - Tamaños de las imágenes a descargar
			  - Solo valores en:
			#{ALLOWED_VALUES[:download]}
			  - Por defecto [1000] * 8
			  - Ejemplo:
			      #{EXAMPLES[:download]}
		TXT
		"upload" => <<~TXT,
			--upload=(Arreglo de Enteros)
			  - Tamaño de las cadenas a subir
			  - Por defecto [4000000] * 8
			  - Ejemplo:
			      #{EXAMPLES[:upload]}
		TXT
		"debug" => <<~TXT,
			--debug=(Cadena)
			  - Cadena a formatear
			  - Solo valores en:
			#{ALLOWED_VALUES[:debug]}
			  - Ejemplo:
				  --debug="Velocidad: %{download} %{upload}"
		TXT
		"delay" => <<~TXT,
			--delay=(Entero)
			  - Tiempo a esperar entre corridas
			  - Ejemplo:
			    --delay=20
		TXT
		"runs" => <<~TXT,
			--runs=(Entero o Cadena)
			  - Veces a correr el bloque
			  - La única Cadena válida es: "infinity"
			  - Ejemplo:
			    --runs=5
		TXT
		"file" => <<~TXT,
			--file=(Cadena)
			  - Archivos al caul se le guardará el output
			  - Ejemplo:
			    --file="~/Documentos/velocidad-del-internet.log"
		TXT
		"print_errors" => <<~TXT,
			--print_errors=(Booleano)
			  - Imprime errores de conección
			  - Por defecto: false
		TXT
	}
}.in_lang








