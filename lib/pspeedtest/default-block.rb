
class PSpeedTest
	DEFAULT_BLOCK = proc {|test|
		puts nil, "--- Running test ---", nil
		
		puts "User:"
		puts USER.update!.to_s debug: <<~TXT
			#{"  "}IP: %{ip}
			#{"  "}Coordinates: %<lat>.4f, %<lon>.4f
			
		TXT
		
		puts "Server:"
		puts SERVER.update!.to_s debug: <<~TXT
			#{"  "}Sponsor: %{sponsor} (%{host})
			#{"  "}Latency: %<latency>.4fms
			#{"  "}Coordinates: %<lat>.4f, %<lon>.4f (%<distance>.2fkm)
			
		TXT
		
		puts "Starting download tests:"
		download = SERVER.download_speed test.to_download,
			debug: "  downloading %{url}\n"
		puts download.to_s debug: <<~TXT
			Took %<time>.4f seconds to download %{bits} bits [%{bps}]
			
		TXT
		
		puts "Starting upload tests:"
		upload = SERVER.upload_speed test.to_upload,
			debug: "  uploading %{bytes} to %{url}\n"
		puts upload.to_s debug: <<~TXT
			Took %<time>.4f seconds to upload %{bits} bits [%{bps}]
			
		TXT
		
		[download, upload]
	}
end
	




 







