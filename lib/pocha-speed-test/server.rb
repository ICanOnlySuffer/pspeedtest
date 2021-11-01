
class PochaSpeedTest
	SERVERS_URL = "https://www.speedtest.net/speedtest-servers.php"
	
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
			when :compact
				<<~TEXT % [host, lat, lon]
					host: %s, lat: %.#{decimals}f, lon: %.#{decimals}f
				TEXT
			else
				raise "Error: no mode %s for server.to_s" % mode.inspect
			end
		end
		
		def ping enumerator = 1.times
			enumerator.map {
				start = Time.now
				page = HTTParty.get "http://%s/speedtest/latency.txt" % host
				Time.now - start
			}.sum * 100 / n rescue Float::INFINITY
		end
		
		def update! ping: 1.times, max: 10
			self.lat, self.lon, self.host, self.sponsor, self.latency = *(
				Server.get_best ping: ping, max: max
			)
			self
		end
		
		def download_speed sizes = @@download_sizes, debug: nil, spacing: "  "
			threads = sizes.map {|size|
				url = "http://#{host}/speedtest/random#{size}x#{size}.jpg"
				debug_line = case debug
				when :default, true
					spacing + "downloading " + url + ?\n
				when :censored
					spacing + "downloading " \
					"http://<host>/speedtest/random%#{size}x%#{size}.jpg\n"
				else
					""
				end
				
				Thread.new {
					print debug_line
					(HTTParty.get url).length
				}
			}
			
			start = Time.now
			bytes = (threads.map &:value).sum
			Speed.new Time.now - start, bytes
		end
		
		def upload_speed sizes = @@upload_sizes, debug: nil, spacing: "  "
			url = "http://#{host}/speedtest/upload.php"
			
			threads = sizes.map {|size|
				debug_line = case debug
					when :default, true
						spacing + "uploading #{size.bytes decimals: 0} to " \
						"#{url}\n"
					when :censored
						spacing + "uploading " + size.bytes + " to " \
						"http://<host>/speedtest/upload.php\n"
					else
						""
					end
				Thread.new {
					print debug_line
					(HTTParty.post url, body: ?A * size) [/\d+/].to_i
				}
			}
			
			start = Time.now
			bytes = (threads.map &:value).sum
			Speed.new Time.now - start, bytes
		end
		
		def self.get_best ping: @@ping, max: 10
			( # probably not best practices, but it is fast for sure
				(
					HTTParty.get SERVERS_URL
				) ["settings"]["servers"]["server"].filter_map {|data|
					Server.new *[
						data ["lat"].to_f,
						data ["lon"].to_f,
						data ["host"],
						data ["sponsor"]
					]
				}.sort_by &:distance
			) [0, max].sort_by {|server|
				server.latency = server.ping ping
			}.first
		end
	end
	
	SERVER = Server.new
end









