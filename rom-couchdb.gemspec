# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rom/couchdb/version'

Gem::Specification.new do |spec|
  spec.name          = 'rom-couchdb'
  spec.version       = ROM::CouchDB::VERSION
  spec.authors       = ['Hunter Madison']
  spec.email         = ['hunterglenmadison@icloud.com']

  spec.summary       = 'CouchDB support for ROM'
  spec.homepage      = 'https://github.com/hmadison'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test)/})}
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rom', '~> 2.0.0'
  spec.add_runtime_dependency 'couchrest', '~> 2.0.0'

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
end
