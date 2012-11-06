# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zig/version'

Gem::Specification.new do |gem|
  gem.name          = "zig"
  gem.version       = ZIG::VERSION
  gem.authors       = ["Tim Lossen"]
  gem.email         = ["tim@lossen.de"]
  gem.description   = %q{A parser for the ZIG data format.}
  gem.summary       = %q{A parser for the ZIG data format.}
  gem.homepage      = "https://github.com/tlossen/zig"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^test/})
  gem.require_paths = ["lib"]
end
