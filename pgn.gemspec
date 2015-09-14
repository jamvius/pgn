# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pgn/version'

Gem::Specification.new do |spec|
  spec.name          = "pgn"
  spec.version       = PGN::VERSION
  spec.authors       = ["jamvius"]
  spec.email         = ["jamvius@gmail.com"]
  spec.description   = %q{A PGN parser and FEN generator for Ruby}
  spec.summary       = %q{A PGN parser for Ruby}
  spec.homepage      = "https://github.com/jamvius/pgn"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "whittle"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
