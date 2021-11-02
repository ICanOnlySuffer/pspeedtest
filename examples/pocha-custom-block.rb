require_relative "../lib/pocha-speed-test"

test = PochaSpeedTest.new do
	puts <<-TEXT
		
		This is a custom block in which I can define
		a custom behaviour for my test and what will
		it return.
		
		I just need to remember to have updated USER
		and SERVER at least once since by default all
		their values are nil.
	
	TEXT
	
	puts "User:", PochaSpeedTest::USER.update!
	puts "Server:", PochaSpeedTest::SERVER.update!
	
	puts
	
	puts "Testing download speed..."
	download_speed = PochaSpeedTest::SERVER.download_speed
	puts "  #{download_speed}"
	
	puts "Testing upload speed..."
	upload_speed = PochaSpeedTest::SERVER.upload_speed
	puts "  #{upload_speed}"
	
	puts
	
	puts "Finished epicly."
	
	download_speed.time + upload_speed.time
end

time = test.run

test.on_run do
	puts <<-TEXT % time
		
		If I happen to want to change the behaviour
		of my test i can just do it easily with the
		:on_run method which allows a new block to
		be set replacing the previous one.
		
		Also in this scenario I don't really need
		to update USER or SERVER since it has passed
		so little time it would be very unlikely
		that the server I was connected to is down
		or that I have a different internet
		connection than %.4f seconds ago.
		
	TEXT
	
	puts "Testing speed..."
	puts <<~TEXT
		Download: #{PochaSpeedTest::SERVER.download_speed}
		Upload: #{PochaSpeedTest::SERVER.upload_speed}
	TEXT
	
	puts "Finished."
end

test.run








