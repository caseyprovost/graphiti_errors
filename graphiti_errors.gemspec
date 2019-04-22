lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "graphiti_errors/version"

Gem::Specification.new do |spec|
  spec.name          = "graphiti_errors"
  spec.version       = GraphitiErrors::VERSION
  spec.authors       = ["Lee Richmond"]
  spec.email         = ["lrichmond1@bloomberg.net"]

  spec.summary       = "Error-handling patterns for JSONAPIs"
  spec.description   = "Handles application errors and model validations"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "jsonapi-serializable", "~> 0.1"

  # Rails is added in Appraisals
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec-rails", "~> 3.0"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "graphiti_spec_helpers", ">= 1.0.alpha.3"
  spec.add_development_dependency "standard"
end
