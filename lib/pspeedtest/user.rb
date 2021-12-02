
class PSpeedTest
private
	User = Struct.new :ip, :lat, :lon do
		def to_s debug: ""
			debug % {
				ip: ip,
				lat: lat,
				lon: lon
			}
		end
	end

public
	USER = User.new
	
	def USER.update!
		data = (
			HTTParty.get <<~URL.chomp
				http://www.speedtest.net/speedtest-config.php
			URL
		) ["settings"]["client"]
		
		USER.ip  = data ["ip"]
		USER.lat = data ["lat"].to_f
		USER.lon = data ["lon"].to_f
		
		USER
	end
end




