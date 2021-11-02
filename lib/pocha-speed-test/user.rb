
class PochaSpeedTest
	module USER
		
		# pain
		
		def self.ip
			@@ip
		end
		def self.lat
			@@lat
		end
		def self.lon
			@@lon
		end
		
		# not pain
		
		def self.update!
			data = (
				HTTParty.get "http://www.speedtest.net/speedtest-config.php"
			) ["settings"]["client"]
			
			@@ip  = data ["ip"]
			@@lat = data ["lat"].to_f
			@@lon = data ["lon"].to_f
			
			USER # helps doing stuff like: puts USER.update!
		end
		
		def self.to_s mode: :default, spacing: "  ", decimals: 4
			case mode
			when :default
				<<~TEXT % [spacing, @@ip, spacing, @@lat, @@lon]
					%sIP: %s
					%sCoords: %.#{decimals}f, %.#{decimals}f
				TEXT
			when :compact
				<<~TEXT % [@@ip, @@lat, @@lon]
					ip: %s, lat: %.#{decimals}, lon: %.#{decimals}
				TEXT
			else
				raise "Error: no mode: %s for User.to_s" % mode.inspect
			end
		end
	end
end





