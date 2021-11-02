require_relative "pocha-speed-test/version"
require_relative "pocha-speed-test/blocks"

require_relative "pocha-speed-test/server"
require_relative "pocha-speed-test/user"

require_relative "pocha-speed-test/speed"

require "httparty"

class PochaSpeedTest
	attr_accessor :download_sizes, :upload_sizes, :ping, :block
	
	@@download_sizes = [1_000] * 8
	@@upload_sizes = [400_000] * 8
	@@block = BLOCKS[:default]
	@@ping = 4.times
	
	def run enumerator = 1.times
		enumerator.each do
			@block.call self
		end
	end
	
	def on_run &block
		@block = block
	end
	
	def initialize ping: @@ping,
			download_sizes: @@download_sizes,
			upload_sizes: @@upload_sizes,
			&block
		
		@download_sizes = download_sizes
		@upload_sizes = upload_sizes
		@block = block || @@block
		@ping = ping
	end
end






