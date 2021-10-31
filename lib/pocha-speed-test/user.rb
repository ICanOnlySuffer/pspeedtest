
class PochaSpeedTest
	module User
		STRING_FORMAT = "User\n  IP: %s\n  Coords: %s"
		@@geopoint = GeoPoint.new
		
		def self.ip
			@@ip
		end
		def self.ip= ip
			@@ip = ip
		end
		def self.geopoint
			@@geopoint
		end
		def self.geopoint= geopoint
			@@geopoint = geopoint
		end
		
		def self.update
			page = HTTParty.get "http://www.speedtest.net/speedtest-config.php"
			scan = page.body.match /ip="([^"]*)" lat="([^"]*)" lon="([^"]*)"/
			ip, latitude, longitude = scan.captures
			
			@@ip = ip
			@@geopoint.latitude = latitude.to_f
			@@geopoint.longitude = longitude.to_f
		end
		
		def self.print mode: 0, spacing: "  ", decimals: 4
			puts case mode
			when 0, :normal
				"User\n%sIP: %s%sCoords: %.#{decimals}f, %.#{decimals}f" % [
					spacing, @@ip, spacing, *@@geopoint.values
				]
			when 1, :compact
				"User: {IP: %s, Coords: [%.#{decimals}f %.#{decimals}f]}" % [
					@@ip, @@geopoints.latitude, @@geopoint.longitude
				]
			else
				"Error: printing mode #{mode} for User"
			end
		end
	end
end





