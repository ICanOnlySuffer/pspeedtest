require File.expand_path "../lib", __FILE__

Gem::Specification.new do |spec|
	spec.name    = "pocha-speed-test"
	spec.version = PochaSpeedTest::VERSION
	spec.authors = ["ICanOnlySuffer"]
	
	spec.summary     = "Test internet speed"
	spec.description = "A more \"modular\" version of petemyron's speedtest gem"
	spec.license     = "MIT"
	
	spec.files         = `git ls-files -z`.split ?\0
	spec,require_paths = ["lib"]
	
	spec.add_runtime_dependency "httparty", "~> 0.13"
end




