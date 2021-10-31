
class PochaSpeedTest
	Server = Struct.new :url, :geopoint, :latency do
		ALPHABET = %w{A B C D E F G H I J K L M N O P Q R S T U V W X Y Z}
		
		def coords
			"%.4f, %.4f" % geopoint.values
		end
		
		def distance
			geopoint.distance_to *User.geopoint
		end
		
		def coords_distance
			"%s [%.2fkm]" % [coords, distance]
		end
		
		def ping n = 1
			n.times.map {
				start = Time.now
				page = HTTParty.get "%s/speedtest/latency.txt" % url
				Time.now - start
			}.sum * 100 / n rescue Float::INFINITY
		end
		
		def get_download_speed sizes = [1000, 2000]
			start = Time.now
			bytes = sizes.map {|size|
				url = "%s/speedtest/random%ix%i.jpg" % [self.url, size, size]
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
		
		def get_upload_speed sizes = [2000, 4000]
			url = "%s/speedtest/upload.php" % self.url
			
			strings = sizes.map {|size|
				size.times.map {
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
			data = (
				HTTParty.get "http://www.speedtest.net/speedtest-servers.php"
			).body.scan /url="([^"]*)" lat="([^"]*)" lon="([^"]*)/
			
			servers = data.filter_map {|url, latitude, longitude|
				url = url[/http:\/\/.+\d+/]
				geopoint = GeoPoint.new latitude.to_f, longitude.to_f
				Server.new url, geopoint if url
			}.sort_by &:distance
			
			servers [0, max].sort_by {|server|
				server.latency = server.ping pings
			}.first
		end
		
		def to_best! pings: 1, max: 10
			best = Server.get_best pings: pings, max: max
			
			self.url = best.url
			self.geopoint = best.geopoint
			self.latency = best.latency
		end
	end
end









