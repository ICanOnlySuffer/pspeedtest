
class PochaSpeedTest
	Server = Struct.new :lat, :lon, :host, :sponsor, :latency do
		def distance lat = USER.lat, lon = USER.lon
			a = (
				(Math.sin ((lat - self.lat) * Math::PI / 360)) ** 2 +
				(Math.cos self.lat * Math::PI / 180) *
				(Math.cos lat * Math::PI / 180) *
				(Math.sin ((lon - self.lon) * Math::PI / 360)) ** 2
			)
			
			12742 * (Math.atan2 (Math.sqrt (a)), (Math.sqrt (1 - a)))
		end
		
		def to_s mode: :default, decimals: 4, spacing: "  "
			case mode
			when :default
				<<~TEXT % [spacing, host, spacing, lat, lon, distance]
					%sHost: %s
					%sCoords: %.#{decimals}f, %.#{decimals}f [%.2fkm]
				TEXT
			when :detailed
				<<~TEXT % [spacing, sponsor, host, spacing, lat, lon, distance]
					%sSponsor: %s (%s)
					%sCoords: %.#{decimals}f, %.#{decimals}f [%.2fkm]
				TEXT
			when :compact
				<<~TEXT % [spacing, host, lat, lon]
					%shost: %s, lat: %.#{decimals}f, lon: %.#{decimals}f
				TEXT
			else
				raise "Error: no mode %s for server.to_s" % mode.inspect
			end
		end
		
		def ping
			begin
				start = Time.now
				HTTParty.get "http://#{host}/speedtest/latency.txt"
				(Time.now - start) * 100
			rescue
				Float::INFINITY
			end
		end
		
		def download_speed sizes = [1_000] * 8, debug: nil, spacing: "  "
			threads = sizes.map {|size|
				url = "http://#{host}/speedtest/random#{size}x#{size}.jpg"
				
				debug_line = case debug
				when :default, true
					spacing + "downloading " + url + ?\n
				when :censored
					spacing + "downloading " \
					"http://<host>/speedtest/random%#{size}x%#{size}.jpg\n"
				end
				
				Thread.new {
					print debug_line
					(HTTParty.get url).length
				}
			}
			
			start = Time.now
			Speed.new (threads.map &:value).sum, Time.now - start
		end
		
		def upload_speed sizes = [400_000] * 8, debug: nil, spacing: "  "
			url = "http://#{host}/speedtest/upload.php"
			
			threads = sizes.map {|size|
				
				debug_line = case debug
				when :default, true
					spacing + "uploading #{size.bytes decimals: 0} to " \
					"#{url}\n"
				when :censored
					spacing + "uploading #{size.bytes decimals: 0} to " \
					"http://<host>/speedtest/upload.php\n"
				end
				
				Thread.new {
					print debug_line
					(HTTParty.post url, body: ?A * size) [/\d+/].to_i
				}
			}
			
			start = Time.now
			Speed.new (threads.map &:value).sum, Time.now - start
		end
		
		def self.fetch buffer_size: 10
			(
				HTTParty.get "https://speedtest.net/speedtest-servers.php"
			) ["settings"]["servers"]["server"].map {|data|
				Server.new *[
					data ["lat"].to_f,
					data ["lon"].to_f,
					data ["host"],
					data ["sponsor"]
				]
			} [0, buffer_size] rescue [] # connection error
		end
		
		def self.nearby
			self.fetch.sort_by &:distance
		end
		
		def self.best buffer_size: 10
			self.nearby[0, buffer_size].sort_by {|server|
				server.latency = server.ping
			}.first || Server.new
		end
	end
	
	# To facilitate working with only one server
	
	SERVER = Server.new
	
	def SERVER.update! buffer_size: 10
		SERVER.lat, SERVER.lon, SERVER.host, SERVER.sponsor, SERVER.latency = *(
			Server.best buffer_size: buffer_size
		)
		
		SERVER # helps doing stuff like: puts SERVER.update!
	end
end









