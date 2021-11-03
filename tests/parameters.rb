require_relative "../lib/pocha-speed-test"

test = PochaSpeedTest.new ping: 1.times,
	download_sizes: [350, 500, 750, 1_000],
	upload_sizes: [10_000, 20_000, 30_000]

test.run




