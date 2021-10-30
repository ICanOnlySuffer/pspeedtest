
module PochaSpeedTest
	module TestBlocks
		DEFAULT = proc do |test|
			puts "\n--- Running test ---\n\n"
			
			User.update
			puts "User\n  IP: %s\n  Coords: %s" % [User.ip, User.coords]
			
			server = Server.get_best pings: test.pings
			puts "Server\n  URL: %s\n  Coords: %s\n  Latency: %.2fms" % [
				server.url, server.coords_distance, server.latency
			]
			
			puts "\nStarting download tests:"
			puts test.download_sizes.map {|size|
				"  downloading %s/speedtest/random%ix%i.jpg" % [
					server.url, size, size
				]
			}.join ?\n
			download_speed = server.get_download_speed test.download_sizes
			puts "Took %.4f seconds to download %i bytes (%s)" % [
				download_speed.time, download_speed.bytes.sum, download_speed
			]
			
			puts "\nStarting upload tests:"
			puts test.upload_sizes.map {|size|
				"  uploading %s to %s/speedtest/upload.php" % [
					(size.bytes decimals: 0), server.url
				]
			}.join ?\n
			upload_speed = server.get_upload_speed test.upload_sizes
			puts "Took %.4f seconds to upload %i bytes (%s)" % [
				upload_speed.time, upload_speed.bytes.sum, upload_speed
			]
			
			Result.new server, download_speed, upload_speed
		end
		
		CENSORED = proc do |test|
			puts "\n--- Running test ---\n\n"
			
			User.update
			
			server = Server.get_best pings: test.pings
			puts "Server latency: %.2fms" % server.latency
			
			puts "\nStarting download tests:"
			puts test.download_sizes.map {|size|
				"  downloading <url>/speedtest/random%ix%i.jpg" % [
					size, size
				]
			}.join ?\n
			download_speed = server.get_download_speed test.download_sizes
			puts "Took %.4f seconds to download %i bytes (%s)" % [
				download_speed.time, download_speed.bytes.sum, download_speed
			]
			
			puts "\nStarting upload tests:"
			puts test.upload_sizes.map {|size|
				"  uploading %s to <url>/speedtest/upload.php" % (
					size.bytes decimals: 0
				)
			}.join ?\n
			upload_speed = server.get_upload_speed test.upload_sizes
			puts "Took %.4f seconds to upload %i bytes (%s)" % [
				upload_speed.time, upload_speed.bytes.sum, upload_speed
			]
			
			Result.new server, download_speed, upload_speed
		end
		
		NO_OUTPUT = proc do |test|
			User.update
			server = Server.get_best pings: test.pings
			
			download_speed = server.get_download_speed test.download_sizes
			upload_speed   = server.get_upload_speed test.upload_sizes
			
			Result.new server, download_speed, upload_speed
		end
	end	
end
	




 







