# frozen_string_literal: true

require_relative "lib/pspeedtest/version"

Gem::Specification.new do |spec|
	spec.name    = "pspeedtest"
	spec.version = PSpeedTest::VERSION
	spec.authors = ["ICanOnlySuffer"]
	
	spec.summary     = "Test internet speed."
	spec.description = "An internet speed tester"
	spec.homepage    = "https://github.com/ICanOnlySuffer/pspeedtest"
	spec.license     = "MIT"
	
	spec.required_ruby_version = ">= 2.6.0"
	
	spec.files = Dir["lib/**/*", "bin/*"]
	
	spec.bindir        = "bin"
	spec.executables   = ["pspeedtest"]
	spec.require_paths = ["lib"]
	
	spec.post_install_message = ?\n + {
		"en" => "Thanks a lot for downloading pspeedtest!",
		"es" => "Muchas gracias por descargar pspeedtest!"
	} [(ENV["LANG"] || "en") [..1]] + ?\n
	
	spec.add_runtime_dependency "httparty", "~> 0.13"
	
	spec.add_development_dependency "bundler", "~> 2.0"
	spec.add_development_dependency "rspec", "~> 3.0"
	spec.add_development_dependency "rake", "~> 10.0"
end








