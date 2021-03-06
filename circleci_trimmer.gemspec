# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "circleci_trimmer/version"

Gem::Specification.new do |spec|
  spec.name          = "circleci_trimmer"
  spec.version       = CircleciTrimmer::VERSION
  spec.authors       = ["yukimura1227"]
  spec.email         = ["takamura1227@gmail.com"]

  spec.summary       = %q{this is circleci api wrapper}
  spec.description   = %q{this gem give you some commands for circleci api}
  spec.homepage      = 'https://github.com/yukimura1227/circleci_trimmer'
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_development_dependency 'codecov'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'pry-doc'

  spec.add_dependency 'thor'
  spec.add_dependency 'httpclient'
  spec.add_dependency 'hashie'
end
