require 'net/http'

module PSpeedTest
	VERSION = '2.3.0'
	
	Speed = Struct.new :bits, :time do
		def bps
			case div = (bits.fdiv time)
			when ...1_024 then [div, 'bps']
			when ...1_048_576 then [div / 1024, 'Kbps']
			when ...1_073_741_824 then [div / 1_048_576, 'Mbps']
			else [div / 1_073_741_824, 'Gbps']
			end
		end
	end
	
	FETCH_URI = URI 'https://c.speedtest.net/speedtest-servers.php'
	DOWNLOAD_URL = 'http://%s/speedtest/random%ix%i.jpg'
	UPLOAD_URL = 'http://%s/speedtest/upload.php'
	PING_URL = 'http://%s/speedtest/latency.txt'
	
	Server = Struct.new :lat, :lon, :sponsor, :host, :latency do
		def download sizes
			threads = sizes.map {|size|
				uri_url = URI DOWNLOAD_URL % [host, size, size]
				Thread.new do
					(Net::HTTP.get uri_url).length
				end
			}
			
			start = Time.now
			Speed.new (threads.sum &:value) * 8, Time.now - start
		end
		
		def upload sizes
			uri_url = URI UPLOAD_URL % host
			threads = sizes.map {|size|
				Thread.new do
					(
						Net::HTTP.post_form uri_url, ['A' * size]
					).body[5..].to_i
				end
			}
			
			start = Time.now
			Speed.new (threads.sum &:value) * 8, Time.now - start
		end
		
		def self.fetch
			(
				(
					(
						(
							Net::HTTP.get FETCH_URI
						).force_encoding 'UTF-8'
					).scan /(?:lat|lon|sponsor|host)="([^"]+)"/
				).flatten.each_slice 4
			).map {|lat, lon, sponsor, host|
				Server.new lat.to_f, lon.to_f, sponsor, host
			}
		end
		
		def self.get_best
			threads = self.fetch.map {|server|
				thread = Thread.new do
					start = Time.now
					Net::HTTP.get (URI PING_URL % server.host)
					server.latency = (Time.now - start) * 100
					(threads - [thread]).each &:kill
					server
				end
			}
			
			(threads.find &:value).value rescue Hash.new
		end
	end
	
	SERVER = Server.new
	def SERVER.update!
		Server.get_best.each_pair {|name, value|
			SERVER[name] = value
		}
	end
end

