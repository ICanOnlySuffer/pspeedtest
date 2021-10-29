
class Numeric
	def radians
		self * Math::PI / 180
	end
end

module SpeedTest
	GeoPoint = Struct.new :latitude, :longitude do
		def distance_to latitude, longitude
			phi_1 = Math.cos self.latitude.radians
			phi_2 = Math.cos latitude.radians
			
			delta_phi = (latitude - self.latitude).radians
			delta_lambda = (longitude - self.longitude).radians
			
			sin_1 = Math.sin delta_phi / 2
			sin_2 = Math.sin delta_lambda / 2
			
			a = sin_1 ** 2 + phi_1 * phi_2 * sin_2 ** 2
			
			12742 * (Math.atan2 (Math.sqrt (a)), (Math.sqrt (1 - a)))
		end
	end
end












