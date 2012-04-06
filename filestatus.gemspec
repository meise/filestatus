# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dme/filestatus/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Daniel Meißner"]
  gem.email         = ["dm@3st.be"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = "https://github.com/meise/filestatus"

  gem.rubyforge_project = nil
  gem.has_rdoc          = 'yard'
  gem.extra_rdoc_files  = ['HISTORY.md', 'LICENSE.md']

  gem.files             = `git ls-files`.lines.map(&:chomp)
  gem.test_files       = `git ls-files -- {test,spec,features}/*`.lines.map(&:chomp)
  gem.executables       = `git ls-files -- bin/*`.lines.map{|f| File.basename(f.chomp) }
  gem.require_paths     = ["lib"]

  gem.name              = "filestatus"
  gem.require_paths     = ["lib"]
  gem.version           = Dme::Filestatus::VERSION

  gem.extra_rdoc_files  = ['HISTORY.md', 'LICENSE.md']

  gem.required_ruby_version = '>= 1.8.9'

  gem.add_development_dependency('bundler', '~> 1.1.0')
  gem.add_development_dependency('rake', '~> 0.9.2')
  gem.add_development_dependency('rspec', '~> 2.8.0')
  gem.add_development_dependency('xmpp4r', '~> 0.5')
  gem.add_development_dependency('fssm', '~> 0.2.8.1')
end
