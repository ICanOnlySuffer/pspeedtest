
PochaSpeedTest = Struct.new :download, :upload, :servers, :block

require_relative "pocha-speed-test/version"
require_relative "pocha-speed-test/blocks"
require_relative "pocha-speed-test/server"
require_relative "pocha-speed-test/speed"
require_relative "pocha-speed-test/user"

require "httparty"

puts <<~TEXT
	[DEPRECATION NOTICE]
	The new version of this gem also comes with a name change. The new
	name of the project is 'pspeedtest', and since RubyGems doesn't
	support renaming, this version with the old name will be deprecated
	while the new one keeps being updated.
	
	Installation:
	$ gem install pspeedtest
TEXT

class PochaSpeedTest
	def run enumerator = 1.times
		enumerator.map do
			self.block.call self
		end
	end
	
	def on_run &block
		self.block = block
	end
	
	def initialize download: [1_000] * 12, upload: [400_000] * 12, &block
		self.download = download
		self.upload = upload
		
		self.block = block || BLOCKS[:default]
	end
end




