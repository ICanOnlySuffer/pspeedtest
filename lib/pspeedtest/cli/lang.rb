
LANG = ENV['LANG']

class Hash
	def translate
		self[LANG] || self[LANG[..1]] || self['en']
	end
end

