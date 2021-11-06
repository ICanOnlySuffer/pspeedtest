
class PochaSpeedTest
	BLOCKS = {
		default: proc {|test|
			puts "--- Running test ---", nil
			
			puts "User:", USER.update!
			puts "Server:", SERVER.update!
			
			puts "\nStarting download tests:"
			download = SERVER.download_speed test.download, debug: true
			puts download.details "download"
			
			puts "\nStarting upload tests:"
			upload = SERVER.upload_speed test.upload, debug: true
			puts upload.details "upload"
			
			[download, upload]
		},
		
		censored: proc {|test|
			puts "--- Running test ---"
						
			USER.update!
			SERVER.update!
			
			puts "\nStarting download tests:"
			download = SERVER.download_speed test.download, debug: :censored
			puts download.details "download"
			
			puts "\nStarting upload tests:"
			upload = SERVER.upload_speed test.upload, debug: :censored
			puts upload.details "upload"
			
			[download, upload]
		},
		
		no_output: proc {|test|
			USER.update!
			SERVER.update!
			
			[
				(SERVER.download_speed test.download),
				(SERVER.upload_speed test.upload)
			]
		}
	}.freeze
end
	




 







