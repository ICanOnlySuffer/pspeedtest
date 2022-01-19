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
		
		def to_s debug: ""
			debug % {
				distance: distance,
				latency: latency,
				sponsor: sponsor,
				host: host,
				lat: lat,
				lon: lon
			}
		end
		
		def ping
			(
				start = Time.now
				HTTParty.get URL_PING % host
				(Time.now - start) * 100
			) rescue Float::INFINITY
		end
		
		def test_download sizes, debug: ""
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
		
		def test_upload sizes, debug: ""
			url = UPLOAD_URL % host
			
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
		
		def self.get_bests
			bests = []
			
			threads = self.fetch.map {|server|
				Thread.new {
					(
						start = Time.now
						HTTParty.get URL_PING % server.host
						server.latency = (Time.now - start) * 100
						bests << server
						threads.each &:kill
					) rescue nil
				}
			}
			threads.each &:join
			
			bests.sort_by &:latency
		end
	end
	
	SERVER = Server.new
	
	def SERVER.update! buffer_size: 10
		(
			Server.get_bests.first || Hash.new
		).each_pair {|name, value|
			SERVER[name] = value
		}
		
		SERVER
	end
end









