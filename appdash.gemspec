# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name          = "appdash"
  s.version       = "0.6.1"
  s.authors       = ["Black Square Media"]
  s.email         = ["dimitrij@blacksquaremedia.com"]
  s.summary       = %q{Appdash client for ruby}
  s.description   = %q{Ruby client for Appdash, Sourcegraph's application tracing system, based on Google's Dapper}
  s.homepage      = "https://github.com/bsm/appdash-rb"
  s.required_ruby_version = '>= 1.9.0'

  s.files         = `git ls-files`.split($/)
  s.test_files    = s.files.grep(%r{^(spec)/})
  s.require_paths = ["lib"]

  s.add_dependency(%q<protobuf>)

  s.add_development_dependency(%q<rake>)
  s.add_development_dependency(%q<rack>)
  s.add_development_dependency(%q<bundler>)
  s.add_development_dependency(%q<rspec>)
  s.add_development_dependency(%q<rack-test>)
end
