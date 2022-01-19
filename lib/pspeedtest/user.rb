require 'httparty'

module PSpeedTest
	URL_USER = 'http://www.speedtest.net/speedtest-config.php'
	USER = (Struct.new :ip, :lat, :lon).new
	
	def USER.update!
		data = (HTTParty.get URL_USER) ['settings']['client']
		
		USER.ip  = data ['ip']
		USER.lat = data ['lat'].to_f
		USER.lon = data ['lon'].to_f
		
		USER
	end
end




