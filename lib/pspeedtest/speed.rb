
class Numeric
	def bytes decimals: 0
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
		(bytes decimals: 2).downcase + "ps" # tss
	end
	
	alias :bps :bits_per_second
end

class Array
	def average &block
		size.zero? ? (block ? (sum block) : sum) / size : 0
	end
end

class PSpeedTest
	Speed = Struct.new :bits, :time do
		def bps
			(bits / time).bps
		end
		
		def to_s debug: "%{bps}"
			debug % {
				bits: bits,
				time: time,
				bps: bps
			}
		end
		
		def + speed
			Speed.new self.bits + speed.bits, self.time
		end
		
		def / amount
			Speed.new self.bits / amount, self.time
		end
		
		def self.average speeds
			Speed.new (speeds.average &:bits), (speed.average &:time)
		end
	end
end




