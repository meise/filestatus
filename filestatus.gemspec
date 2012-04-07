# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dme/filestatus/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name                  = Dme::Filestatus::NAME.downcase
  gem.version               = Dme::Filestatus::VERSION
  gem.require_paths         = ["lib"]

  gem.authors               = ["Daniel Meißner"]
  gem.email                 = ["dm@3st.be"]
  gem.description           = 'Filestatus is a status monitor daemon to monitor the state files and directories'
  gem.summary               = <<-SUMMARY
Filestatus is a file and directory status monitor daemon. It sends notifications to configured informer if a status has
been changed.
  SUMMARY
  gem.homepage              = "https://github.com/meise/filestatus"

  gem.rubyforge_project     = nil
  gem.has_rdoc              = 'yard'

  gem.files                 = `git ls-files`.lines.map(&:chomp)
  gem.test_files            = `git ls-files -- {test,spec,features}/*`.lines.map(&:chomp)
  gem.executables           = `git ls-files -- bin/*`.lines.map{|f| File.basename(f.chomp) }
  gem.require_paths         = ["lib"]
  gem.extra_rdoc_files      = ['LICENSE.md']

  gem.required_ruby_version = '>= 1.9.2'

  gem.add_dependency('daemons', '~> 1.1.8')
  gem.add_dependency('xmpp4r', '~> 0.5')
  gem.add_dependency('fssm', '~> 0.2.8.1')
  gem.add_dependency('rainbow', '~> 1.1.3')

  gem.add_development_dependency('bundler', '~> 1.1.0')
  gem.add_development_dependency('rake', '~> 0.9.2')
  gem.add_development_dependency('rspec', '~> 2.9.0')
  gem.add_development_dependency('simplecov', '~> 0.6.1')
end
