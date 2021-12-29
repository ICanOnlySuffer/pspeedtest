# frozen_string_literal: true

require_relative "lib/pspeedtest/version"

Gem::Specification.new do |spec|
	spec.name    = "pspeedtest"
	spec.version = PSpeedTest::VERSION
	spec.authors = ["ICanOnlySuffer"]
	
	spec.summary     = "Test internet speed with speedtest.net servers"
	spec.description = "Test internet speed with speedtest.net servers"
	spec.homepage    = "https://github.com/ICanOnlySuffer/pspeedtest"
	spec.license     = "MIT"
	
	spec.required_ruby_version = ">= 3.0.0"
	
	spec.files = Dir["lib/**/*", "bin/**/*"]
	
	spec.bindir        = "bin"
	spec.executables   = ["pspeedtest"]
	spec.require_paths = ["lib"]
	
	spec.post_install_message = <<~TXT
		
		Thanks a lot for downloading pspeedtest!
		
		Bug reports, suggestions and contributions at:
		> https://github.com/ICanOnlySuffer/pspeedtest
		
	TXT
	
	spec.add_runtime_dependency "httparty", "~> 0.13"
	
	spec.add_development_dependency "bundler", "~> 2.0"
	spec.add_development_dependency "rspec", "~> 3.0"
	spec.add_development_dependency "rake", "~> 10.0"
end








