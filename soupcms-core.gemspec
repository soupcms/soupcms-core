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
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib','ui']

  spec.add_dependency('tilt')
  spec.add_dependency('slim')
  spec.add_dependency('sprockets-helpers')
  spec.add_dependency('sass')

end
