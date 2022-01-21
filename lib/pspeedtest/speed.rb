
module PSpeedTest
	Speed = Struct.new :bits, :time do
		def bps
			div = bits.fdiv time
			{
				'bps'  => 1024,
				'Kbps' => 1048576,
				'Mbps' => 1073741824,
				'Gbps' => 1099511627776
			}.each {|string, max|
				return [div * 1024 / max, string] if max > div
			}
		end
	end
end




