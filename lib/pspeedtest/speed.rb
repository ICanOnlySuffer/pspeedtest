
module PSpeedTest
	Speed = Struct.new :bits, :time do
		def bps
			div = bits.fdiv time
			{
				'bps'  => 1_024,
				'Kbps' => 1_048_576,
				'Mbps' => 1_073_741_824,
				'Gbps' => 1_099_511_627_776
			}.each {|string, max|
				return [div * 1024 / max, string] if max > div
			}
		end
	end
end




