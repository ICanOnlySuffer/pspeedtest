
class PochaSpeedTest
	BLOCKS = {
		default: proc {
			puts "\n--- Running test ---\n\n"
			
			puts "User:", USER.update!
			puts "Server:", SERVER.update!
			
			puts "\nStarting download tests:"
			download_speed = SERVER.download_speed debug: true
			puts download_speed.details
			
			puts "\nStarting upload tests:"
			upload_speed = SERVER.upload_speed debug: true
			puts upload_speed.details
			
			[download_speed, upload_speed]
		},
		
		censored: proc {
			puts "\n--- Running test ---\n"
			
			USER.update!
			SERVER.update!
			
			puts "\nStarting download tests:"
			download_speed = SERVER.download_speed debug: :censored
			puts download_speed.details
			
			puts "\nStarting upload tests:"
			upload_speed = SERVER.upload_speed debug: :censored
			puts upload_speed.details
			
			[download_speed, upload_speed]
		},
		
		no_output: proc {
			USER.update!
			SERVER.update!
			
			[server.download_speed, server.upload_speed]
		}
	}.freeze
end
	




 







