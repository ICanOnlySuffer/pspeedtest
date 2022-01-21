require_relative 'speed'
require_relative 'user'

module PSpeedTest
	Server = Struct.new :lat, :lon, :host, :sponsor, :latency do
		URL_DOWNLOAD = 'http://%s/speedtest/random%ix%i.jpg'
		URL_UPLOAD = 'http://%s/speedtest/upload.php'
		URL_FETCH ='https://speedtest.net/speedtest-servers.php'
		URL_PING = 'http://%s/speedtest/latency.txt'
		
		def distance lat = USER.lat, lon = USER.lon
			a = (
				(Math.sin ((lat - self.lat) * Math::PI / 360)) ** 2 +
				(Math.cos self.lat * Math::PI / 180) *
				(Math.cos lat * Math::PI / 180) *
				(Math.sin ((lon - self.lon) * Math::PI / 360)) ** 2
			)
			12742 * (Math.atan2 (Math.sqrt (a)), (Math.sqrt (1 - a)))
		end
		
		def download sizes, debug: ""
			threads = sizes.map {|size|
				url = URL_DOWNLOAD % [host, size, size]
				
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
		
		def upload sizes, debug: ""
			url = URL_UPLOAD % host
			
			threads = sizes.map {|size|
				debug_string = debug % {
					url: url,
					size: size
				}
				
				Thread.new {
					print debug_string
					(HTTParty.post url, body: ?A * size) [/\d+/].to_i
				}
			}
			
			start = Time.now
			Speed.new (threads.sum &:value) * 8, Time.now - start
		end
		
		def self.fetch
			(
				HTTParty.get URL_FETCH
			) ['settings']['servers']['server'].map {|data|
				Server.new *[
					data ['lat'].to_f,
					data ['lon'].to_f,
					data ['host'],
					data ['sponsor']
				]
			}
		end
		
		def self.get_best
			best = Hash.new
			threads = self.fetch.map {|server|
				thread = Thread.new {
					(
						start = Time.now
						HTTParty.get URL_PING % server.host
						server.latency = (Time.now - start) * 100
						best = server
						(threads - [thread]).each &:kill
					) rescue nil
				}
			}
			threads.each &:join
			
			best
		end
	end
	
	SERVER = Server.new
	
	def SERVER.update! buffer_size: 10
		Server.get_best.each_pair {|name, value|
			SERVER[name] = value
		}
		
		SERVER
	end
end









