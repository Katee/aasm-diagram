# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'aasm_diagram/version'

Gem::Specification.new do |spec|
  spec.name          = 'aasm-diagram'
  spec.version       = AASMDiagram::VERSION
  spec.authors       = ['Kate Murphy']
  spec.email         = ['hello@kate.io']

  spec.summary       = 'Automatically generate diagrams of AASM state machines.'
  spec.homepage      = 'https://github.com/katee/aasm-diagram'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'aasm', '~> 4.12'
  spec.add_runtime_dependency 'ruby-graphviz', '~> 1.2'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
