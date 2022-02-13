require 'pspeedtest/info'
include PSpeedTest

Gem::Specification.new do |spec|
	spec.name    = 'pspeedtest'
	spec.authors = AUTHORS.keys
	spec.version = VERSION
	
	spec.summary     = SUMMARY
	spec.description = SUMMARY
	spec.homepage    = GITHOME
	spec.license     = LICENSE
	
	spec.required_ruby_version = '>= 3.0.0'
	
	spec.files         = Dir['lib/**/*', 'bin/**/*']
	spec.bindir        = 'bin'
	spec.executables   = ['pspeedtest']
	spec.require_paths = ['lib']
	
	spec.post_install_message = <<~TXT
		Thanks a lot for downloading pspeedtest!
		You can contribute at: #{GITHOME}
	TXT
	
	spec.add_development_dependency 'bundler', '~> 2.0'
	spec.add_development_dependency 'rake', '~> 10.0'
end

