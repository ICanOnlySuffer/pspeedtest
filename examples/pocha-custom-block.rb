require_relative "../lib/pocha-speed-test"

test = PochaSpeedTest.new do
	puts "\n--- Running epic test with my custom block ---\n\n"
	
	puts "User:", PochaSpeedTest::USER.update!
	puts "Server:", PochaSpeedTest::SERVER.update!
	
	puts
	
	puts "Download speed: #{PochaSpeedTest::SERVER.download_speed [1_000] * 4}"
	puts "Upload speed: #{PochaSpeedTest::SERVER.upload_speed [1_000_000] * 4}"
	
	puts
	
	puts "Finished epicly."
end

test.run




