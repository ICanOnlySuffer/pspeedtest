
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
		
		def + speed
			Speed.new self.bytes + speed.bytes, self.time + speed.time
		end
		
		def / amount
			Speed.new self.bytes / amount, self.time / amount
		end
		
		def details what, decimals: 4
			"Took %.#{decimals}f seconds to %s %i bytes [%s]" % [
				time, what, bytes, bits.bps
			]
		end
		
		def self.average speeds
			sum_bytes = speeds.sum &:bytes
			sum_time = speeds.sum &:time
			
			Speed.new sum_bytes / speeds.size, sum_time / speeds.size
		end
	end
end




