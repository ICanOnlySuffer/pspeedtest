
class Numeric
	def bytes decimals: 2
		string, max = {
			"b"  => 1024,
			"Kb" => 1048576,
			"Mb" => 1073741824,
			"Gb" => 1099511627776
		}.find {|key, max|
			max > self
		}
		
		"%.#{decimals}f%s" % [self * 1024 / max, string]
	end
	def bps
		bytes + "ps"
	end
end









