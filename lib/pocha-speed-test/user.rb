
class PochaSpeedTest
	User = Struct.new :ip, :lat, :lon do
		def to_s mode: :default, spacing: "  ", decimals: 4
			case mode
			when :default
				<<~TEXT % [spacing, ip, spacing, lat, lon]
					%sIP: %s
					%sCoords: %.#{decimals}f, %.#{decimals}f
				TEXT
			when :compact
				<<~TEXT % [ip, lat, lon]
					ip: %s, lat: %.#{decimals}, lon: %.#{decimals}
				TEXT
			else
				raise "Error: no mode: %s for User.to_s" % mode.inspect
			end
		end
	end
	
	USER = User.new
	
	def USER.update!
		data = (
			HTTParty.get "http://www.speedtest.net/speedtest-config.php"
		) ["settings"]["client"]
		
		USER.ip  = data ["ip"]
		USER.lat = data ["lat"].to_f
		USER.lon = data ["lon"].to_f
		
		USER # helps doing stuff like: puts USER.update!
	end
end




