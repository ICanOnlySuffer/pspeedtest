
module PochaSpeedTest
	Speed = Struct.new :time, :bytes do
		def bytes_per_second
			bytes.sum * 8 / time
		end
		def to_s decimals: 4
			"Took %.#{decimals}f seconds to download %i bytes [%s]" % [
				time, bytes.sum, bytes_per_second.bps
			]
		end
	end
end


