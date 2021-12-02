
PSpeedTest = Struct.new :to_download, :to_upload, :servers, :block

require_relative "pspeedtest/version"
require_relative "pspeedtest/blocks"
require_relative "pspeedtest/server"
require_relative "pspeedtest/speed"
require_relative "pspeedtest/user"
require_relative "pspeedtest/lang"

require "httparty"

class PSpeedTest
	def run enumerator = 1.times
		enumerator.map do
			self.block.call self
		end
	end
	
	def on_run &block
		self.block = block
	end
	
	def initialize download: [1_000] * 12, upload: [400_000] * 12, &block
		self.to_download = download
		self.to_upload = upload
		
		self.block = block || DEFAULT_BLOCK
	end
end




