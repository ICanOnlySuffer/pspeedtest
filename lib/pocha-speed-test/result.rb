
module PochaSpeedTest
	Result = Struct.new :server, :download_speed, :upload_speed do
		def to_s
			"%s\n  Download speed: %s\n  Upload speed: %s" % [
				server, download_speed.bps, upload_speed.bps
			]
		end
	end
end




