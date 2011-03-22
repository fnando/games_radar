# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "games_radar/version"

Gem::Specification.new do |s|
  s.name        = "games_radar"
  s.version     = GamesRadar::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nando Vieira"]
  s.email       = ["fnando.vieira@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/games_radar"
  s.summary     = "GamesRadar is an API wrapper for the games website http://gamesradar.com"
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "nokogiri", "~> 1.4.4"
  s.add_development_dependency "fakeweb", "~> 1.3.0"
end
