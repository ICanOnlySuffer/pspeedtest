
module PSpeedTest
	Speed = Struct.new :bits, :time do
		def bps decimals: 2
			bits_div_time = bits / time
			
			string, max = {
				'bps'  => 1024,
				'Kbps' => 1048576,
				'Mbps' => 1073741824,
				'Gbps' => 1099511627776
			}.find {|key, max|
				max > bits_div_time
			}
			
			"%.#{decimals}f%s" % [bits / time * 1024 / max, string]
		end
		
		alias :to_s :bps
	end
end




