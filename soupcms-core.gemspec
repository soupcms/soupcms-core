# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'soupcms/core/version'

Gem::Specification.new do |spec|
  spec.name          = 'soupcms-core'
  spec.version       = Soupcms::Core::VERSION
  spec.authors       = ['Sunit Parekh']
  spec.email         = ['parekh.sunit@gmail.com']
  spec.summary       = %q{soupCMS core project provides core CMS capability of building pages with data recipe and ui recipe.}
  spec.description   = %q{soupCMS core project provides core CMS capability of building pages with data recipe and ui recipe.}
  spec.homepage      = 'http://www.soupcms.com/soucms-core'
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency('mongo', '~> 1.9.2')
  spec.add_dependency('bson_ext', '~> 1.9.2')
  spec.add_dependency('grape', '~> 0.6.1')
  spec.add_dependency('faraday', '~> 0.8.8')

end
