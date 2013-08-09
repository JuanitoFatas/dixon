# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dixon/version'

Gem::Specification.new do |spec|
  spec.platform      = Gem::Platform::RUBY

  spec.name          = "dixon"
  spec.version       = Dixon::VERSION

  spec.authors       = ["Juanito Fatas"]
  spec.email         = ["katehuang0320@gmail.com"]

  spec.description   = %q{Dixon checks your identification number!}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/JuanitoFatas/dixon"

  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
