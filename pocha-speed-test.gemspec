# frozen_string_literal: true

require_relative "lib/pocha-speed-test/version"

Gem::Specification.new do |spec|
	spec.name    = "pocha-speed-test"
	spec.version = PochaSpeedTest::VERSION
	spec.authors = ["ICanOnlySuffer"]
	
	spec.summary     = "Test internet speed."
	spec.description = "A more \"modular\" version of petemyron's speedtest gem"
	spec.homepage    = "https://github.com/ICanOnlySuffer/PochaSpeedTest"
	spec.license     = "MIT"
	
	spec.required_ruby_version = ">= 2.6.0"
	
	spec.files = Dir.chdir(File.expand_path(__dir__)) do
		(`git ls-files -z`.split "\x0").reject do |file|
			file.match /pkg|#{__FILE__}/
		end
	end
	
	spec.bindir        = "exe"
	spec.executables   = spec.files.grep /\Aexe\// {|file|
		File.basename file
	}
	spec.require_paths = ["lib"]
	
	spec.add_runtime_dependency "httparty", "~> 0.13"
	
	spec.add_development_dependency "bundler", "~> 2.0"
	spec.add_development_dependency "rspec", "~> 3.0"
	spec.add_development_dependency "rake", "~> 10.0"
end








