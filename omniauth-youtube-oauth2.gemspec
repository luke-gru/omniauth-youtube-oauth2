# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth/you_tube_oauth2/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'omniauth-google-oauth2'
  gem.add_dependency 'activesupport'

  gem.authors       = ["Luke Gruber"]
  gem.email         = ["lgruber@mentel.com"]
  gem.description   = %q{A YouTube oauth2 strategy for OmniAuth}
  gem.summary       = %q{A YouTube oauth2 strategy for OmniAuth}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.name          = "omniauth-youtube-oauth2"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::YouTubeOauth2::VERSION
end
