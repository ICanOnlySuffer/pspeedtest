
class Numeric
	def radians
		self * Math::PI / 180
	end
end

class PochaSpeedTest
	GeoPoint = Struct.new :lat, :lon do
		def distance_to lat, lon
			a = (
				(Math.sin ((lat - self.lat).radians / 2)) ** 2 +
				(Math.cos self.lat.radians) *
				(Math.cos latitude.radians) *
				(Math.sin ((lon - self.lon).radians / 2)) ** 2
			)
			
			12742 * (Math.atan2 (Math.sqrt (a)), (Math.sqrt (1 - a)))
		end
	end
end












