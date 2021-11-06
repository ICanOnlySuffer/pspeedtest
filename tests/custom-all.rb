require_relative "../lib/pocha-speed-test"

downloads = []
uploads = []

PochaSpeedTest.new download: [1_000] * 4, upload: [800_000] * 4 do |test|
	puts "User:", PochaSpeedTest::USER.update!
	puts "Server:", PochaSpeedTest::SERVER.update!
	
	puts "Downloading images..."
	download = PochaSpeedTest::SERVER.download_speed test.download
	puts "  Download speed: #{download}"
	
	puts "Uploading strings..."
	upload = PochaSpeedTest::SERVER.upload_speed test.download
	puts "  Upload speed: #{upload}"
	
	puts
	
	downloads << download
	uploads << upload
end.run 4.times

puts "Average download speed: #{(downloads.inject :+) / 4}"
puts "Average upload speed: #{(uploads.inject :+) / 4}"















