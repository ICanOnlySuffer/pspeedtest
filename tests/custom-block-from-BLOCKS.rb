require_relative "../lib/pocha-speed-test"

test = PochaSpeedTest.new
puts <<~TEXT
	Test created with default block
	#{"  "}(PochaSpeedTest::BLOCKS[:default])
TEXT
test.run

puts

test.block = PochaSpeedTest::BLOCKS[:censored]
puts <<~TEXT
	Test.block set to censored block
	#{"  "}(PochaSpeedTest::BLOCKS[:censored])
TEXT
test.run





