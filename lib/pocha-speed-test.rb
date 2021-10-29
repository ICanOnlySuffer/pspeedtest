require_relative "pocha-speed-test/geo-point"
require_relative "pocha-speed-test/bytes"
require "httparty"

module PochaSpeedTest
	module User
		@@geopoint = GeoPoint.new
		
		def self.ip
			@@ip
		end
		def self.ip= ip
			@@ip = ip
		end
		def self.geopoint
			@@geopoint
		end
		def self.geopoint= geopoint
			@@geopoint = geopoint
		end
		def self.to_s
			"User\n  IP: %s\n  Coords: %.4f, %.4f" % [@@ip, *@@geopoint.to_a]
		end
	end
	
	Server = Struct.new :url, :geopoint, :latency do
		def ping times
			times.times.map do
				start = Time.now
				begin
					page = HTTParty.get "%s/speedtest/latency.txt" % url
				rescue Timeout::Error, Net::HTTPNotFound, Errno::ENETUNREACH
					# nuthin
				rescue Errno::ECONNRESET
					# damn
				end
				Time.now - start
			end.sum * 1000 / times
		end
		def distance
			geopoint.distance_to *User.geopoint
		end
		def coords
			"%.4f, %.4f [%.2fkm]" % [*geopoint, distance]
		end
		def to_s
			"Server\n  URL: %s\n  Coords: %s\n  Latency: %.2fms" % [
				url, coords, latency
			]
		end
	end
	
	class Test
		ALPHABET = %w{A B C D E F G H I J K L M N O P Q R S T U V W X Y Z}
		
		Result = Struct.new :server, :download_rate, :upload_rate
		
		def initialize options = {}
			@download_runs = options [:download_runs] || [350, 500]
			@upload_runs   = options [:upload_runs]   || [350, 500]
			@ping_runs     = options [:ping_runs]     || 2
			@debug         = options [:debug]         || false
			
			update_user
		end
		
		def update_user
			page = HTTParty.get "http://www.speedtest.net/speedtest-config.php"
			scan = page.body.match /ip="([^"]*)" lat="([^"]*)" lon="([^"]*)"/
			ip, latitude, longitude = scan.captures
			
			User.ip = ip
			User.geopoint.latitude = latitude.to_f
			User.geopoint.longitude = longitude.to_f
		end
		
		def logs message
			puts message if @debug
		end
		
		def auto_server
			page = HTTParty.get "http://www.speedtest.net/speedtest-servers.php"
			scan = page.body.scan /url="([^"]*)" lat="([^"]*)" lon="([^"]*)/
			
			servers = scan.map do |server|
				url = server [0][/http:\/\/.+\d+/]
				geopoint = GeoPoint.new server [1].to_f, server [2].to_f
				
				Server.new url, geopoint
			end.select &:url
			
			servers.sort_by! &:distance
			
			@server = servers [0, 10].sort_by do |server|
				server.latency = server.ping @ping_runs
			end.first
		end
		
		def download
			logs "Starting download tests:"
			
			start = Time.now
			
			threads = @download_runs.map do |run|
				Thread.new do |thread|
					url = "%s/speedtest/random%ix%i.jpg" % [
						@server.url, run, run
					]
					
					logs "  downloading: %s" % url
					page = HTTParty.get url
					Thread.current["downloaded"] = page.body.length
				end
			end
			
			threads.map! do |thread|
				thread.join
				thread ["downloaded"]
			end
			
			time = Time.now - start
			
			logs "Took %.4f seconds to download %i bytes (%i threads)" % [
				time, threads.sum, threads.size
			]
			
			threads.sum * 8 / time
		end
		
		def upload
			logs "Starting upload tests:"
			url = "%s/speedtest/upload.php" % @server.url
			
			strings = @upload_runs.map do |run|
				run.times.map do
					ALPHABET[rand 26]
				end.join
			end
			
			start = Time.now
			
			threads = strings.map do |string|
				Thread.new do |thread|
					logs "  uploading: %s" % url
					page = HTTParty.post url, body: {"content": string}
					body_split = page.body.split ?=
					Thread.current["uploaded"] = body_split [1].to_i
				end
			end
			
			threads.map! do |thread|
				thread.join
				thread ["uploaded"]
			end
			
			time = Time.now - start
			
			logs "Took %.4f seconds to upload %i bytes (%i threads)" % [
				time, threads.sum, threads.size
			]
			
			threads.sum * 8 / time
		end
		
		def run
			logs User
			auto_server
			logs @server
			
			logs ""
			download_rate = download
			logs "Download: %s" % download_rate.bytes
			
			logs ""
			upload_rate = upload
			logs "Upload: %s" % upload_rate.bytes
			
			Result.new @server, download_rate, upload_rate
		end
	end
end
	




 







