
class Numeric
	UNITS = {
		"bit/s"  => ...1024,
		"Kbit/s" => ...1048576,
		"Mbit/s" => ...1073741824
	}.freeze
	
	def bytes
		size = UNITS.each do |key, range|
			break key if range.include? self
		end
		
		position = UNITS.keys.index size
		number   = self * 1024 ** -position
		string   = UNITS.keys[position]
		
		"%.2f%s" % [number, string]
	end
end










