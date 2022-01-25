require_relative 'speed'
require_relative 'user'

module PSpeedTest
	Server = Struct.new :lat, :lon, :host, :sponsor, :latency do
		URL_DOWNLOAD = 'http://%s/speedtest/random%ix%i.jpg'
		URL_UPLOAD = 'http://%s/speedtest/upload.php'
		URL_FETCH ='https://c.speedtest.net/speedtest-servers.php'
		URL_PING = 'http://%s/speedtest/latency.txt'
		
		def distance lat_2 = USER.lat, lon_2 = USER.lon
			12742 * Math.asin(
				Math.sqrt(
					Math.sin((lat_2 - lat) * Math::PI / 360) ** 2 +
					Math.sin((lon_2 - lon) * Math::PI / 360) ** 2 *
					Math.cos(lat_2 * Math::PI / 180) *
					Math.cos(lat * Math::PI / 180)
				)
			)
		end
		
		def download sizes
			threads = sizes.map {|size|
				url = URL_DOWNLOAD % [host, size, size]
				Thread.new do
					(HTTParty.get url).length
				end
			}
			
			start = Time.now
			Speed.new (threads.sum &:value) * 8, Time.now - start
		end
		
		def upload sizes
			url = URL_UPLOAD % host
			
			threads = sizes.map {|size|
				Thread.new do
					(HTTParty.post url, body: ?A * size) [/\d+/].to_i
				end
			}
			
			start = Time.now
			Speed.new (threads.sum &:value) * 8, Time.now - start
		end
		
		def self.fetch
			(
				HTTParty.get URL_FETCH
			) ['settings']['servers']['server'].map {|data|
				Server.new(
					data ['lat'].to_f,
					data ['lon'].to_f,
					data ['host'],
					data ['sponsor']
				)
			}
		end
		
		def self.get_best
			best = Hash.new
			
			threads = self.fetch.map {|server|
				thread = Thread.new do
					start = Time.now
					HTTParty.get URL_PING % server.host
					server.latency = (Time.now - start) * 100
					best = server
					(threads - [thread]).each &:kill
				end
			}
			
			threads.each &:join
			best
		end
	end
	
	SERVER = Server.new
	
	def SERVER.update!
		Server.get_best.each_pair {|name, value|
			SERVER[name] = value
		}
		
		SERVER
	end
end









