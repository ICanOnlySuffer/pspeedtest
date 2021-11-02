
class PochaSpeedTest
	BLOCKS = {
		default: proc {|test|
			puts "--- Running test ---", nil
			
			puts "User:", USER.update!
			puts "Server:", SERVER.update!
			
			puts "\nStarting download tests:"
			download_speed = SERVER.download_speed test.download_sizes,
				debug: true
			puts download_speed.details
			
			puts "\nStarting upload tests:"
			upload_speed = SERVER.upload_speed test.upload_sizes,
				debug: true
			puts upload_speed.details
			
			[download_speed, upload_speed]
		},
=begin
		# probably next update, pushing a new one soon because of mayor bug
		detailed: proc {
			puts "\n--- Running test ---\n\n"
			
			puts "User:", USER.update!
			puts "Server:", (SERVER.update!.to_s :detailed)
			
			
		},
=end
		censored: proc {|test|
			puts "--- Running test ---", nil
			
			USER.update!
			SERVER.update!
			
			puts "\nStarting download tests:"
			download_speed = SERVER.download_speed test.download_sizes,
				debug: :censored
			puts download_speed.details
			
			puts "\nStarting upload tests:"
			upload_speed = SERVER.upload_speed test.upload_sizes,
				debug: :censored
			puts upload_speed.details
			
			[download_speed, upload_speed]
		},
		
		no_output: proc {|test|
			USER.update!
			SERVER.update!
			
			[
				(SERVER.download_speed test.download_sizes),
				(SERVER.upload_speed test.upload_sizes)
			]
		}
	}.freeze
end
	




 







