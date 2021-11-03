
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
	
	def bits_per_second
		bytes.downcase + "ps"
	end
	
	alias :bps :bits_per_second
end

class PochaSpeedTest
	Speed = Struct.new :bytes, :time do
		def bits
			bytes * 8 / time
		end
		
		def to_s
			bits.bps
		end
		
		def details decimals: 4
			"Took %.#{decimals}f seconds to download %i bytes [%s]" % [
				time, bytes, bits.bps
			]
		end
	end
end




