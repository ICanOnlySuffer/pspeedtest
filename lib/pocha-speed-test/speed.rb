
module PochaSpeedTest
	Speed = Struct.new :time, :bytes do
		def to_s
			(bytes.sum * 8 / time).bps
		end
	end
end


