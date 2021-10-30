
module PochaSpeedTest
	Speed = Struct.new :time, :bytes do
		def to_s
			(bytes.sum * 8 / time).bytes
		end
	end
end


