# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-slug'
  spec.version       = '0.2.0'
  spec.authors       = ['Robert Coleman']
  spec.email         = ['github@robert.net.nz']
  spec.summary       = %q{Capistrano tasks to make deployment artifacts}
  spec.description   = %q{Capistrano tasks to make deployment artifacts}
  spec.homepage      = 'https://github.com/rjocoleman/capistrano-slug'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
end
