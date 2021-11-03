
PochaSpeedTest = Struct.new :download, :upload, :servers, :block

require_relative "pocha-speed-test/version"
require_relative "pocha-speed-test/blocks"
require_relative "pocha-speed-test/server"
require_relative "pocha-speed-test/speed"
require_relative "pocha-speed-test/user"

require "httparty"

class PochaSpeedTest
	def run enumerator = 1.times
		enumerator.each do
			self.block.call self
		end
	end
	
	def on_run &block
		self.block = block
	end
	
	def download_speed
		self.servers.map {|server|
			server.download_speed self.download_sizes
		}
	end
	
	def upload_speed
		self.servers.map {|server|
			server.upload_speed self.upload_sizes
		}
	end
	
	def initialize servers: [],
		download: [1_000] * 8,
		upload: [400_000] * 8,
		&block
		
		self.servers = servers
		
		self.download = download
		self.upload = upload
		
		self.block = block || BLOCKS[:default]
	end
end




