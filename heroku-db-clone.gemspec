# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'heroku-db-clone/version'

Gem::Specification.new do |gem|
  gem.name          = "heroku-db-clone"
  gem.version       = HerokuDbClone::VERSION
  gem.authors       = ["Cameron Pope"]
  gem.email         = ["cameron@theaboutbox.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""
  gem.executables   << 'heroku-db-clone'
  gem.add_dependency('trollop','~> 2.0.0')

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
