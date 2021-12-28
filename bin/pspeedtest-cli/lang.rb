
LANG = ENV["LANG"].to_s

class Hash
	def in_lang
		(
			value = self [LANG] or value = self [LANG[..1]]
		) ? value : self ["en"]
	end
end




