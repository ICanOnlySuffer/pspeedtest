
class PSpeedTest
private
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
		
		def to_s debug: ""
			debug % {
				lat: lat,
				lon: lon,
				host: host,
				sponsor: sponsor,
				latency: latency,
				distance: distance,
			}
		end
		
		def ping
			(
				start = Time.now
				HTTParty.get "http://#{host}/speedtest/latency.txt"
				(Time.now - start) * 100
			) rescue Float::INFINITY
		end
		
		def download_speed sizes = [1_000] * 8, debug: ""
			threads = sizes.map {|size|
				url = "http://#{host}/speedtest/random#{size}x#{size}.jpg"
				debug_string = debug % {
					url: url
				}
				
				Thread.new {
					print debug_string
					(HTTParty.get url).length
				}
			}
			
			start = Time.now
			Speed.new (threads.sum &:value) * 8, Time.now - start
		end
		
		def upload_speed sizes = [400_000] * 8, debug: false
			url = "http://#{host}/speedtest/upload.php"
			
			threads = sizes.map {|size|
				debug_string = debug % {
					url: url,
					bytes: size.bytes
				}
				
				Thread.new {
					print debug_string
					(HTTParty.post url, body: ?A * size) [/\d+/].to_i
				}
			}
			
			start = Time.now
			Speed.new (threads.sum &:value) * 8, Time.now - start
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
	
public
	SERVER = Server.new
	
	def SERVER.update! buffer_size: 10
		(
			Server.best buffer_size: buffer_size
		).each_pair {|name, value|
			SERVER[name] = value
		}
		
		SERVER
	end
end









