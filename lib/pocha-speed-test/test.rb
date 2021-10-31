
module PochaSpeedTest
	Test = Struct.new :download_sizes, :upload_sizes, :pings, :block do
		def run times: 1
			(0 .. times).each do
				block.call self
			end
		end
		def on_run &block
			self.block = block
		end
	end
	
	# - Looking much nicer now!
	def self.new download_sizes: nil, upload_sizes: nil, pings: nil, &block
		download_sizes ||= [    1_000,     1_500,     2_000,     2_500]
		upload_sizes   ||= [1_000_000, 1_000_000, 1_000_000, 1_000_000]
		block          ||= TestBlocks::DEFAULT
		pings          ||= 4
		
		Test.new download_sizes, upload_sizes, pings, block
	end
end
	




 







