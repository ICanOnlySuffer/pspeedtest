require_relative 'lang'

ALLOWED = {
	download: '500, 750, 1000, 1500, 2000, 2500, 3000, 3500',
	debug: (
		[
			'host (string)',
			'sponsor (string)',
			'latency (float) ',
			'longitude (float)',
			'distance (float)',
			'distance.m (float)',
			'distance.mi (float)',
			'download.num (float)',
			'download.str (string)',
			'download.bits (integer)',
			'download.time (float)',
			'upload.num (float)',
			'upload.str (string)',
			'upload.bits (integer)',
			'upload.time (float)'
		].join "\n    "
	)
}

EXAMPLE = {
	download: '--download="500 1500 2500 3500"',
	upload: '--upload="2000000 4000000 6000000 8000000"',
	debug: '--debug="speed: %<download.num>.4f %{download.str}\n"',
	file: '--file="~/Documents/internet.txt"'
}

USAGE = {
	'en' => <<~TXT,
		Usage: pspeedtest --OPTION=VALUE ...
		Options:
	TXT
	'es' => <<~TXT,
		Uso: pspeedtest --OPCIÓN=VALOR ...
		Opciones:
	TXT
}.translate

HELP = {
	'en' => {
		'download' => <<~TXT,
			- Sizes of the images to download
			- Allowed values:
			    %{allowed.download}
			- Example:
			    %{example.download}
		TXT
		'upload' => <<~TXT,
			- Sizes of the strings to upload
			- Example:
			    %{example.upload}
		TXT
		'debug' => <<~TXT,
			- String to be formated
			- Allowed values:
			    %{allowed.debug}
			- Example:
			    %{example.debug}
		TXT
		'delay' => <<~TXT,
			- Seconds to sleep between runs
		TXT
		'runs' => <<~TXT,
			- Times to run the block
			- An integer or 'inf' to run infinitely
		TXT
		'file' => <<~TXT,
			- File in which the output will be appended.
			- Example:
			   %{example.file}
		TXT
		'rescue' => <<~TXT,
			- Ommits errors
			- By default: true
		TXT
	},
	'es' => {
		'download' => <<~TXT,
			- Tamaños de las imágenes a descargar
			- Valores permitidos:
			    %{allowed.download}
			- Ejemplo:
			    %{example.download}
		TXT
		'upload' => <<~TXT,
			- Tamaño de las cadenas a subir
			- Ejemplo:
			    %{example.upload}
		TXT
		'debug' => <<~TXT,
			- Cadena a formatear
			- Valores permitidos:
			    %{allowed.debug}
			- Ejemplo:
				%{example.debug}
		TXT
		'delay' => <<~TXT,
			- Tiempo a esperar entre corridas
		TXT
		'runs' => <<~TXT,
			- Veces a correr el bloque
			- Entero o 'inf' para correr indefinidamente
		TXT
		'file' => <<~TXT,
			- Archivos al caul se le guardará el output
			- Ejemplo:
			    %{example.file}
		TXT
		'rescue' => <<~TXT,
			- Omite errores
			- Por defecto: true
		TXT
	}
}.translate

def usage option, description
	puts "  --#{option}", (
		description % {
			'example.download': EXAMPLE[:download],
			'example.upload': EXAMPLE[:upload],
			'example.debug': EXAMPLE[:debug],
			'example.file': EXAMPLE[:file],
			'allowed.download': ALLOWED[:download],
			'allowed.debug': ALLOWED[:debug]
		}
	).lines.map {|line|
		'    ' + line
	}
end

def help value
	if HELP[value]
		usage value, HELP[value]
		exit 0
	end
	
	puts USAGE
	HELP.each {|option, description|
		usage option, description
	}
	exit value ? 1 : 0
end


