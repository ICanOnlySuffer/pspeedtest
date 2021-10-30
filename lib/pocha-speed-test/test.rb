
module PochaSpeedTest
	Test = Struct.new :download_runs, :upload_runs, :ping_runs, :block do
		def run
			block.call self
		end
		def on_run &block
			self.block = block
		end
	end
	
	# - Looking much nicer now!
	def self.new download_runs: nil, upload_runs: nil, pin_runs: nil, &block
		download_runs ||= [1000, 2000]
		upload_runs   ||= [4000, 8000]
		ping_runs     ||= 8
		block         ||= TestBlocks::DEFAULT
		
		Test.new download_runs, upload_runs, ping_runs, &block
	end
end
	




 







