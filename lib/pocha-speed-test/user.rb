
module PochaSpeedTest
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
		def self.coords
			"%.4f, %.4f" % @@geopoint.values
		end
		
		def self.update
			page = HTTParty.get "http://www.speedtest.net/speedtest-config.php"
			scan = page.body.match /ip="([^"]*)" lat="([^"]*)" lon="([^"]*)"/
			ip, latitude, longitude = scan.captures
			
			@@ip = ip
			@@geopoint.latitude = latitude.to_f
			@@geopoint.longitude = longitude.to_f
		end
	end
end





