
# TODO:
#   Make Test::DEFAULT_BLOCK less horrible

module PochaSpeedTest
	class Test
		DEFAULT_BLOCK = proc {|test|
			
			puts "\n--- Running test ---\n\n" if test.debug?
			
			### User ###
			
			User.update
			puts "User\n  IP: %s\n  Coords: %s" % (
				test.censor? ?
				%w{<your-ip> <your-coords>} :
				[User.ip, User.coords]
			) if test.debug?
			
			### Server ###
			
			server = Server.get_best pings: test.ping_runs
			url = test.censor? ? "<url>" : server.url
			
			puts "Server\n  URL: %s\n  Coords: %s [%s]\n  Latency: %.2fms" % (
				test.censor? ?
				[url, "<coords>", "<distance>", server.latency] :
				[url, server.coords, ("%.4f" % server.distance), server.latency]
			) if test.debug?
			
			### Download test ###
			
			if test.debug?
				puts "\nStarting download tests:"
				puts "  downloading images from %s/speedtest/" % url
			end
			
			download_speed = server.get_download_speed
			
			puts "Took %.4f seconds to download %i bytes (%s)" % [
				download_speed.time,
				download_speed.bytes.sum,
				download_speed.to_s
			] if test.debug?
			
			### Upload test ###
			
			if test.debug?
				puts "\nStarting upload tests:"
				puts "  uploading strings to %s/speedtest/upload.php" % url
			end
			
			upload_speed = server.get_upload_speed
			
			puts "Took %.4f seconds to download %i bytes (%s)" % [
				upload_speed.time,
				upload_speed.bytes.sum,
				upload_speed.to_s
			] if test.debug?
			
			### Results ###
			
			result = Result.new server,
				download_speed,
				upload_speed
			
			test.results << result
		}
		
		attr_accessor :results, :ping_runs, :download_runs, :upload_runs
		attr_writer :censor, :debug, :run_block
		
		def initialize options = {}, &run_block
			@download_runs = options [:download_runs] || [1000, 2000]
			@upload_runs   = options [:upload_runs]   || [4000, 8000]
			
			@ping_runs = options [:ping_runs] || 2
			
			@censor = options [:censor] || false
			@debug  = options [:debug]  || false
			
			@results = []
			
			@run_block = run_block || DEFAULT_BLOCK
		end
		
		def censor?
			@censor
		end
		
		def debug?
			@debug
		end
		
		def run
			@run_block.call self
			self
		end
	end
end
	




 







