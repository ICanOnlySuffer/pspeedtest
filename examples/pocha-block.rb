require_relative "../lib/pocha-speed-test"

test = PochaSpeedTest.new
test.on_run &PochaSpeedTest::BLOCKS[:censored]

test.run




