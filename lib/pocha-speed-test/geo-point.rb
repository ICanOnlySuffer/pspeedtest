
class Numeric
	def radians
		self * Math::PI / 180
	end
end

module PochaSpeedTest
	GeoPoint = Struct.new :latitude, :longitude do
		def distance_to latitude, longitude
			a = (
				(Math.sin ((latitude - self.latitude).radians / 2)) ** 2 +
				(Math.cos self.latitude.radians) *
				(Math.cos latitude.radians) *
				(Math.sin ((longitude - self.longitude).radians / 2)) ** 2
			)
			
			12742 * (Math.atan2 (Math.sqrt (a)), (Math.sqrt (1 - a)))
		end
	end
end












