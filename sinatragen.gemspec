lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatragen/version'

Gem::Specification.new do |gem|
  gem.name          = 'sinatragen'
  gem.date          = '2012-10-22'
  gem.version       = SinatraGen::VERSION
  gem.authors       = ['Nick Barth']
  gem.email         = ['nick@nickbarth.ca']
  gem.summary       = 'A Ruby Gem for generating Sinatra applications.'
  gem.description   = 'SinatraGen generates a Sintra application setup and configured for getting up and running quickly with Sinatra.'
  gem.homepage      = 'https://github.com/nickbarth/SinatraGen'
  gem.executables   = ['sinatragen']

  gem.add_development_dependency('rake')
  gem.add_development_dependency('rspec')

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep /spec/
  gem.require_paths = ['lib']
end
