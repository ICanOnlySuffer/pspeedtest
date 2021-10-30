

module PochaSpeedTest
	Server = Struct.new :url, :geopoint, :latency do
		ALPHABET = %w{A B C D E F G H I J K L M N O P Q R S T U V W X Y Z}
		CONNECTION_ERRORS = [
			Errno::ENETUNREACH,
			Errno::ECONNRESET,
			Net::HTTPNotFound,
			Timeout::Error,
			SocketError,
		]
		
		def coords
			"%.4f, %.4f" % geopoint.values
		end
		
		def distance
			geopoint.distance_to *User.geopoint
		end
		
		def coords_distance
			"%s [%.2fkm]" % [coords, distance]
		end
		
		def to_s
			"Server\n  URL: %s\n  Coords: %s\n  Latency: %.2fms" % [
				url, coords, latency
			]
		end
		
		def ping n
			n.times.map {
				start = Time.now
				begin
					page = HTTParty.get "%s/speedtest/latency.txt" % url
				rescue *CONNECTION_ERRORS
					return Float::INFINITY
				end
				Time.now - start
			}.sum * 100 / n
		end
		
		def get_download_speed runs = [1000, 2000]
			start = Time.now
			bytes = runs.map {|run|
				url = "%s/speedtest/random%ix%i.jpg" % [self.url, run, run]
				Thread.new {|thread|
					page = HTTParty.get url
					Thread.current["downloaded"] = page.body.length
				}
			}.map {|thread|
				thread.join
				thread ["downloaded"]
			}
			
			Speed.new Time.now - start, bytes
		end
		
		def get_upload_speed runs = [2000, 4000]
			url = "%s/speedtest/upload.php" % self.url
			
			strings = runs.map {|run|
				run.times.map {
					ALPHABET[rand 26]
				}.join
			}
			
			start = Time.now
			bytes = strings.map {|string|
				Thread.new {|thread|
					page = HTTParty.post url, body: {"content": string}
					Thread.current["uploaded"] = (page.body.split ?=) [1].to_i
				}
			}.map {|thread|
				thread.join
				thread ["uploaded"]
			}
			
			Speed.new Time.now - start, bytes
		end	
		
		def self.get_best pings: 1, max: 10
			page = HTTParty.get "http://www.speedtest.net/speedtest-servers.php"
			scan = page.body.scan /url="([^"]*)" lat="([^"]*)" lon="([^"]*)/
			
			servers = scan.filter_map {|data|
				url = data [0][/http:\/\/.+\d+/]
				geopoint = GeoPoint.new data [1].to_f, data [2].to_f
				
				Server.new url, geopoint if url
			}.sort_by &:distance
			
			servers [0, max].sort_by {|server|
				server.latency = server.ping pings
			}.first
		end
	end
end









