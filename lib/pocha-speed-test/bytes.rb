
class Numeric
	def bytes
		string, max = {
			"bit/s"  => 1024,
			"Kbit/s" => 1048576,
			"Mbit/s" => 1073741824,
			"Gbit/s" => 1099511627776
		}.find {|key, max|
			max > self
		}
		
		"%.2f%s" % [self * 1024 / max, string]
	end
end









