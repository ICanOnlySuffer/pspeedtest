require_relative 'lib/pspeedtest'

Gem::Specification.new do |spec|
	spec.name    = 'pspeedtest'
	spec.authors = ['ICanOnlySuffer']
	spec.version = PSpeedTest::VERSION
	
	spec.summary     = 'Test internet with speedtest.net servers'
	spec.description = 'Test internet with speedtest.net servers'
	spec.homepage    = 'https://github.com/ICanOnlySuffer/pspeedtest'
	spec.license     = 'MIT'
	
	spec.required_ruby_version = '>= 3.0.0'
	
	spec.files = Dir['lib/**/*', 'bin/**/*']
	
	spec.bindir        = 'bin'
	spec.executables   = ['pspeedtest']
	spec.require_paths = ['lib']
	
	spec.post_install_message = <<~TXT
		
		Thanks a lot for downloading pspeedtest!
		
		Bug reports, suggestions and contributions at:
		> https://github.com/ICanOnlySuffer/pspeedtest
		
	TXT
	
	spec.add_development_dependency 'bundler', '~> 2.0'
	spec.add_development_dependency 'rake', '~> 10.0'
end








