
class PochaSpeedTest
	SERVERS_URL = 'https://www.speedtest.net/speedtest-servers.php'.freeze
	
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
		
		# looking beautiful
		def ping enumerator = 1.times
			enumerator.map {
				start = Time.now
				HTTParty.get "http://#{host}/speedtest/latency.txt"
				Time.now - start
			}.sum * 100 / enumerator.size rescue Float::INFINITY
		end
		
		def update! ping: 1.times, max: 10
			self.lat, self.lon, self.host, self.sponsor, self.latency = *(
				Server.best ping: ping, max: max
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
					spacing + "uploading #{size.bytes decimals: 0} to " \
					"http://<host>/speedtest/upload.php\n"
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
		
		# this alias will be removed in next 0.x.0 release
		def self.get_best ping: @@ping, max: 10
			self.best ping: @@ping, max: 10
		end
		
		def self.best ping: t_ping, max: 10
			( # probably not best practices, but it is fast for sure
				( # sometimes return nil, it should be fixed in the next release
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









