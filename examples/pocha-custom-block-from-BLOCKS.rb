require_relative "../lib/pocha-speed-test"

test = PochaSpeedTest.new
puts <<~TEXT
	test created with default block
	#{"  "}(PochaSpeedTest::BLOCK[:default])
TEXT
test.run

puts

test.block = PochaSpeedTest::BLOCKS[:censored]
puts <<~TEXT
	test.block set to censored block
	#{"  "}(PochaSpeedTest::BLOCKS[:censored])
TEXT
test.run





