require_relative "../lib/pocha-speed-test"

test = PochaSpeedTest.new do
	
	puts "User:", PochaSpeedTest::USER.update!
	puts "Server:", PochaSpeedTest::SERVER.update!
	
	puts
	
	puts "Testing download speed..."
	download = PochaSpeedTest::SERVER.download_speed
	puts "  #{download}"
	
	puts "Testing upload speed..."
	upload = PochaSpeedTest::SERVER.upload_speed
	puts "  #{upload}"
	
	puts
	
	puts "Finished epicly."
end

test.run
puts

test.on_run do
	
	puts "Testing speed..."
	puts
	puts "  Download: #{PochaSpeedTest::SERVER.download_speed}"
	puts "  Upload: #{PochaSpeedTest::SERVER.upload_speed}"
	puts
	puts "Finished."
end

test.run








