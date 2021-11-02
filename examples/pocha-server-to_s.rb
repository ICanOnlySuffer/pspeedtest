require_relative "../lib/pocha-speed-test"

test = PochaSpeedTest.new do
	PochaSpeedTest::USER.update!
	PochaSpeedTest::SERVER.update!
	
	%i[default detailed compact].each do |mode|
		puts <<~TEXT
			Server (#{mode}):
			#{PochaSpeedTest::SERVER.to_s mode: mode}
		TEXT
	end
end

test.run




