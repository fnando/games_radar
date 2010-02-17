# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{games_radar}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nando Vieira"]
  s.date = %q{2010-02-17}
  s.description = %q{GamesRadar is an API wrapper for the games website http://gamesradar.com}
  s.email = %q{fnando.vieira@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "CHANGELOG.rdoc",
     "README.rdoc",
     "lib/games-radar.rb",
     "lib/games_radar.rb",
     "lib/games_radar/config.rb",
     "lib/games_radar/errors.rb",
     "lib/games_radar/game.rb",
     "lib/games_radar/genre.rb",
     "lib/games_radar/platform.rb",
     "lib/games_radar/request.rb",
     "lib/games_radar/result.rb",
     "lib/games_radar/version.rb",
     "test/config_test.rb",
     "test/game_test.rb",
     "test/games_radar_test.rb",
     "test/genre_test.rb",
     "test/platform_test.rb",
     "test/request_test.rb",
     "test/resources/game.xml",
     "test/resources/game_not_found.xml",
     "test/resources/games.xml",
     "test/resources/invalid_api_key.xml",
     "test/resources/no_games.xml",
     "test/resources/platforms.xml",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/fnando/games_radar}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{GamesRadar is an API wrapper for the games website http://gamesradar.com}
  s.test_files = [
    "test/config_test.rb",
     "test/game_test.rb",
     "test/games_radar_test.rb",
     "test/genre_test.rb",
     "test/platform_test.rb",
     "test/request_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
    else
      s.add_dependency(%q<nokogiri>, [">= 0"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 0"])
  end
end

